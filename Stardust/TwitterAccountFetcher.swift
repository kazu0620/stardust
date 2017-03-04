//
//  TwitterAccountFetcher.swift
//  Stardust
//
//  Created by kaneko takuji on 2017/03/04.
//  Copyright © 2017年 Stardust. All rights reserved.
//

import Foundation
import RxSwift
import Accounts

struct TwitterAccountFetcher {
    enum FetchError: Error {
        case AccountNotFound
    }
    
    static func account() -> Observable<ACAccount> {
        let accountStore = ACAccountStore()
        let type = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        return Observable.create { observer -> Disposable in
            accountStore
                .requestAccessToAccounts(with: type,
                                         options: nil,
                                         completion:
                    { (granted, error) in
                        if let error = error {
                            observer.onError(error)
                            return
                        }
                        
                        guard granted,
                            let account = accountStore.accounts(with: type).last as? ACAccount else {
                            observer.onError(FetchError.AccountNotFound)
                            return
                        }
                        
                        observer.onNext(account)
                        observer.onCompleted()
                }
            )
            
            return Disposables.create()
        }
    }
}
