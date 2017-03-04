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
    let messageManager = GNSMessageManager(apiKey:"AIzaSyB0kDp-UE6zyyG0SJ7cHhgkbJK10xoiztk")
    //func search() -> Observable<Person> {
    //    
    //}
    
    //
    //func publish(person:Person) {
    //    let publication = messageManager.publication(
    //        with: message,
    //        paramsBlock: { (params: GNSPublicationParams?) in
    //        guard let params = params else { return }
    //        params.strategy = GNSStrategy(paramsBlock: { (params: GNSStrategyParams?) in
    //        guard let params = params else { return }
    //        params.discoveryMediums = .audio
    //            params.discoveryMode = .scan
    //    })
    //    
    //}
}
