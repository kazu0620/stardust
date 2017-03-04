//
//  Person.swift
//  Stardust
//
//  Created by kaneko takuji on 2017/03/04.
//  Copyright © 2017年 Stardust. All rights reserved.
//

import UIKit

struct Person {
    typealias TwitterId = String
    
    let twitterId: TwitterId
    let name: String
    let image: UIImage
    let interests: [Topic]
}
