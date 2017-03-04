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

class TwitterAccountFetcher {
    enum FetchError: Error {
        case AccountNotFound
    }
    
    private let accountStore: ACAccountStore
    private let type: ACAccountType
    
    init() {
        self.accountStore = ACAccountStore()
        self.type = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
    }
    
    func account() -> Observable<ACAccount> {
        return Observable.create { [unowned self] observer -> Disposable in
            self.accountStore
                .requestAccessToAccounts(with: self.type,
                                         options: nil,
                                         completion:
                    { (granted, error) in
                        if let error = error {
                            observer.onError(error)
                            return
                        }
                        
                        guard granted,
                            let account = self.accountStore.accounts(with: self.type).last as? ACAccount else {
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
