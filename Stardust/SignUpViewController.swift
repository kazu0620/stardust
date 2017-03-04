//
//  SignUpViewController.swift
//  Stardust
//
//  Created by kaneko takuji on 2017/03/04.
//  Copyright © 2017年 Stardust. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var connectTwitter: UIButton!
    @IBOutlet weak var username: UITextField!
    var selfie = Variable<UIImage>(UIImage())
    fileprivate let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

private extension SignUpViewController {
    func binding() {
        let viewModel = SignUpViewModel(
            username: username.rx.text.orEmpty.asDriver(),
            image: selfie.asDriver(),
            tapTwitter: connectTwitter.rx.tap.asDriver(),
            tapSignUp: signUp.rx.tap.asDriver()
        )
        
        viewModel
            .isEnabledSignUp
            .drive(signUp.rx.isEnabled)
            .addDisposableTo(disposeBag)
        
        viewModel
            .isEnabledTwitter
            .map{!$0}
            .drive(connectTwitter.rx.isEnabled)
            .addDisposableTo(disposeBag)
        
        viewModel
            .didFinishSignUp
            .drive(onNext: {
                // TODO: 
                print("アカウントが作成できたので画面遷移したい")
            })
            .addDisposableTo(disposeBag)
    }
}
