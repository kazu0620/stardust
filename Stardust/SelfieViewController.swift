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
    
    @IBOutlet weak var selfieImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tapShow(_ sender: Any) {
        showCamera()
    }
    
    func showCamera() {
        self.imagePickerController = UIImagePickerController.init()
        self.imagePickerController.delegate = self
        self.imagePickerController.sourceType = .camera
        self.imagePickerController.cameraDevice = .front
        self.imagePickerController.cameraFlashMode = .off
        
        present(self.imagePickerController, animated: true, completion: nil)
    }
}

extension SelfieViewController {
    func uploadImage() {
        let storage = FIRStorage.storage()
        let storageRef = storage.reference(forURL: "gs://stardustswift-1c8c5.appspot.com")
        if let data = UIImagePNGRepresentation(self.image!) {
            let riversRef = storageRef.child("images/shika_face.png")
            riversRef.put(data, metadata: nil, completion: { metaData, error in
                print(data)
                print(error)
            })
        }
    }
}


extension SelfieViewController:UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let captureImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.image = UIImage.init(cgImage: (captureImage?.cgImage)!,
                                  scale: 0.5,
                                  orientation: .right)
        
        selfieImageView.image = self.image
        
        self.imagePickerController.dismiss(animated: true, completion: {
            self.uploadImage()
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // 
    }
}
