//
//  SignUpViewModel.swift
//  Stardust
//
//  Created by kaneko takuji on 2017/03/04.
//  Copyright © 2017年 Stardust. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct SignUpViewModel {
    private(set) var isEnabledTwitter: Driver<Bool>
    private(set) var isEnabledSignUp: Driver<Bool>

    init(
        username: Driver<String>,
        image: Driver<UIImage>,
        tapTwitter: Driver<Void>,
        tapSignUp: Driver<Void>
        ) {
        
        let fetcher = TwitterAccountFetcher()
        let twitterId = tapTwitter
            .asObservable()
            .withLatestFrom(fetcher.account())
            .map{ $0.identifier as String }
            .asDriver(onErrorJustReturn: nil)
        
        isEnabledTwitter = twitterId
            .map{
                guard let identifier = $0,
                    !identifier.isEmpty else {
                    return false
                }
                return true
            }
        
        let account = Driver.zip(username, image, twitterId){ ($0, $1, $2) }
            .map{ name, image, twitterId -> Person? in
                guard let twitterId = twitterId, !name.isEmpty else {
                    return nil
                }
                
                return Person(twitterId: twitterId,
                              name: name,
                              image: image,
                              interests: [])
            }
        
        isEnabledSignUp = account.map{
            guard let _ = $0 else {
                return false
            }
            return true
        }
        
    }
    
}
