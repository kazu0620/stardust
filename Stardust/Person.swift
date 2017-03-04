//
//  Person.swift
//  Stardust
//
//  Created by kaneko takuji on 2017/03/04.
//  Copyright © 2017年 Stardust. All rights reserved.
//

import UIKit
import Argo
import Runes
import Curry

struct Person {
    typealias TwitterId = String
    
    let twitterId: TwitterId
    let name: String
    let imagePath: String
    let interests: [Topic]
    
    func encode() -> [String:Any] {
        return [
            "twitterId": twitterId,
            "name": name,
            "imagePath": imagePath,
            "interests": interests.map{ $0.rawValue }
        ]
    }
}

extension Person: Decodable {
    static func decode(_ json: JSON) -> Decoded<Person> {
        return curry(Person.init)
            <^> json <| "twitterId"
            <*> json <| "name"
            <*> json <| "imagePath"
            <*> json <|| "interests"
    }
}
