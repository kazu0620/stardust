//
//  SelfieViewController.swift
//  Stardust
//
//  Created by shikata hiroshi on 2017/03/04.
//  Copyright © 2017年 Stardust. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseStorage

class SelfieViewController: UIViewController {

    var imagePickerController:UIImagePickerController!
    var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showCamera() {
        self.imagePickerController = UIImagePickerController.init()
        self.imagePickerController.delegate = self
        self.imagePickerController.sourceType = .camera
        self.imagePickerController.cameraDevice = .front
        
        present(self.imagePickerController, animated: true, completion: nil)
    }
    
    func uploadImage() {
        let storage = FIRStorage.storage()
        let storageRef = storage.reference(forURL: " gs://stardustswift-1c8c5.appspot.com")
        if let data = UIImagePNGRepresentation(self.image!) {
            let riversRef = storageRef.child("images/rivers.jpg")
            riversRef.put(data, metadata: nil, completion: { metaData, error in
                print(data)
                print(error)
            })
        }
    }
}

extension SelfieViewController:UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.imagePickerController.dismiss(animated: true, completion: {
            self.uploadImage()
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        print("testB")
    }
}
