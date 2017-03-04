//
//  ViewController.swift
//  Stardust
//
//  Created by sakamoto kazuhiro on 2017/03/04.
//  Copyright © 2017年 Stardust. All rights reserved.
//

import UIKit
import Argo

class ViewController: UIViewController, PersonEventProtocol, CallEventProtocol {
    internal func childChanged(call: Call, key: String) {
        print("[change]\(key):{\(call)}")
    }

    internal func childAdd(call: Call, key: String) {
        print("[add]\(key):{\(call)}")
    }

    internal func childChanged(person: Decoded<Person>) {
        print("[change]person{\(person)}")
    }

    internal func childAdd(person: Decoded<Person>) {
        print("[add]person{\(person)}")
    }

    var firebaseAccessor: FirebaseAccessor?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        firebaseAccessor = FirebaseAccessor()
        if let accessor = self.firebaseAccessor {
            accessor.personEventProtocol = self
            accessor.callEventProtocol = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

