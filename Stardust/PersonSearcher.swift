//
//  PersonSearcher.swift
//  Stardust
//
//  Created by sakamoto kazuhiro on 2017/03/04.
//  Copyright © 2017年 Stardust. All rights reserved.
//

import Foundation
import RxSwift

class PersonSearcher {
    let disposeBag = DisposeBag()
    let messageManager = GNSMessageManager(apiKey:"AIzaSyBM9XvI0ZUDp9ymqrBlyt1APiz2srXE1j0")
    let nearPersonIds = Variable<[Person.TwitterId]>([])
    private var subscription: GNSSubscription?
    private var publication: GNSPublication?
    
    func startSearching(){
        subscription = messageManager?.subscription(messageFoundHandler: {[weak self] message in
            guard let content = message?.content,
                let twitterId = String(data: content, encoding: .utf8),
                let weakSelf = self
                else { return }
            weakSelf.nearPersonIds.value = weakSelf.nearPersonIds.value + [twitterId]
        }, messageLostHandler: {[weak self] message in
            guard let content = message?.content,
                let twitterId = String(data: content, encoding: .utf8),
                let weakSelf = self
                else { return }
            weakSelf.nearPersonIds.value = weakSelf.nearPersonIds.value.filter{ $0 != twitterId }
        })
    }

    func publish(person:Person) {
        let personData = person.twitterId.data(using: .utf8)
        let message = GNSMessage(content:personData)
        publication = messageManager?.publication(with: message, paramsBlock: nil)
    }
}
