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
    private var personAddRefHandle: FIRDatabaseHandle!
    private var personChangeRefHandle: FIRDatabaseHandle!
    private var callRefHandle: FIRDatabaseHandle!
    private var callAddRefHandle: FIRDatabaseHandle!
    private var callChangeRefHandle: FIRDatabaseHandle!
    
    static let sharedInstance = FirebaseAccessor()
    
    public var persons: [Person]! = []
    public var calls: [Call]! = []
    
    private override init() {
        super.init()
        ref = FIRDatabase.database().reference()
        configureDatabase()
    }
    
    deinit {
        self.ref.child("person").removeObserver(withHandle: personRefHandle)
//        self.ref.child("call").removeObserver(withHandle: callRefHandle)
    }
    
    func configureDatabase() {
        // Listen for new messages in the Firebase database
        personRefHandle
            = self.ref.child("person").observe(.value, with: { [weak self] (snapshot) -> Void in
//            strongSelf.persons.append(snapshot)
                guard let dicts = snapshot.value as? [[String:Any]] else { return }
            
            self?.persons = dicts.flatMap { value -> Person? in
                print(value)

                return decode(value)
            }
                print("[add]person{\(dicts)}")
//            if let personEvent = strongSelf.personEventProtocol,
//                let value = snapshot.value as? [String: Any] {
//                personEvent.childAdd(person: Person.decode(JSON(value)))
//            }
        })
//        personChangeRefHandle
//            = self.ref.child("person").observe(.childChanged, with: { [weak self] (snapshot) -> Void in
//                guard let strongSelf = self else { return }
//                strongSelf.persons.append(snapshot)
//                if let personEvent = strongSelf.personEventProtocol,
//                    let value = snapshot.value as? [String: Any] {
//                    personEvent.childAdd(person: Person.decode(JSON(value)))
//                }
//            })
//        callRefHandle
//            = self.ref.child("call").observe(.value, with: { [weak self] (snapshot) -> Void in
//            guard let strongSelf = self else { return }
//            strongSelf.calls.append(snapshot)
//            print("[add]person{\(snapshot)}")
//            if let callEvent = strongSelf.callEventProtocol,
//                let value = snapshot.value as? [String] {
//                callEvent.childAdd(call: Call(callers: value), key: snapshot.key)
//            }
//        })
//        callChangeRefHandle
//            = self.ref.child("call").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
//                guard let strongSelf = self else { return }
//                strongSelf.calls.append(snapshot)
//                if let callEvent = strongSelf.callEventProtocol,
//                    let value = snapshot.value as? [String] {
//                    callEvent.childAdd(call: Call(callers: value), key: snapshot.key)
//                }
//            })
    }
}
