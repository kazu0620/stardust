//
//  Topic.swift
//  Stardust
//
//  Created by kaneko takuji on 2017/03/04.
//  Copyright © 2017年 Stardust. All rights reserved.
//

import Foundation
import Argo

enum Topic: Int {
    case RxSwift
    case TypeSafe
}

extension Topic: Decodable { }
