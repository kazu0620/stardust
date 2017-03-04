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
import AVFoundation

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var connectTwitter: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var selfieView: UIImageView!
    @IBOutlet weak var camera: UIButton!
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate let selfie = Variable<UIImage?>(nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        bindSelfie()
        bindViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

private extension SignUpViewController {
    func bindViewModel() {
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
    
    func bindSelfie() {
        camera.rx
            .tap
            .asDriver()
            .drive(onNext: { [weak self] in self?.showCamera() })
            .addDisposableTo(disposeBag)
        
        selfie.asDriver()
            .drive(selfieView.rx.image)
            .addDisposableTo(disposeBag)
    }
    
    func showCamera() {
        let imagePickerController = UIImagePickerController.init()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        imagePickerController.cameraDevice = .front
        imagePickerController.cameraFlashMode = .off
        
        present(imagePickerController, animated: true, completion: nil)
    }
}


extension SignUpViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let captureImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        let image = UIImage(cgImage: (captureImage?.cgImage)!,
                            scale: 0.5,
                            orientation: .right)
        
        selfie.value = image
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //
    }
}
