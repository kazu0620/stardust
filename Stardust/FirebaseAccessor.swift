//
//  FirebaseAccessor.swift
//  Stardust
//
//  Created by Kuriyama Toru on 2017/03/04.
//  Copyright © 2017年 Stardust. All rights reserved.
//

import UIKit
import Argo
import Firebase

public protocol PersonEventProtocol {
    func childAdd(person:Decoded<Person>)
    func childChanged(person:Decoded<Person>)
}

public protocol CallEventProtocol {
    func childAdd(call:Call, key:String)
    func childChanged(call:Call, key:String)
}

class FirebaseAccessor: NSObject {
    
    public var personEventProtocol:PersonEventProtocol?
    public var callEventProtocol:CallEventProtocol?
    
    private var ref: FIRDatabaseReference!
    private var storageRef: FIRStorageReference!
    private var personRefHandle: FIRDatabaseHandle!
    private var callRefHandle: FIRDatabaseHandle!
    
    var persons: [FIRDataSnapshot]! = []
    var calls: [FIRDataSnapshot]! = []
    
    override init() {
        super.init()
        ref = FIRDatabase.database().reference()
        configureDatabase()
    }
    
    deinit {
        self.ref.child("person").removeObserver(withHandle: personRefHandle)
        self.ref.child("call").removeObserver(withHandle: callRefHandle)
    }
    
    func configureDatabase() {
        // Listen for new messages in the Firebase database
        personRefHandle = self.ref.child("person").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.persons.append(snapshot)
            print("person:{\(snapshot)}")
            if let personEvent = strongSelf.personEventProtocol,
                let value = snapshot.value as? [String: Any] {
                personEvent.childAdd(person: Person.decode(JSON(value)))
            }
        })
        callRefHandle = self.ref.child("call").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.calls.append(snapshot)
            print("call{\(snapshot)}")
            if let callEvent = strongSelf.callEventProtocol,
                let value = snapshot.value as? [String] {
                callEvent.childAdd(call: Call(callers: value), key: snapshot.key)
            }
        })
    }
}
