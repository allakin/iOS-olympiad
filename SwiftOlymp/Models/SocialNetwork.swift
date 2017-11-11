//
//  SocialNetwork.swift
//  SwiftOlymp
//
//  Created by itisioslab on 11.11.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation

struct SocialNetwork {
    var name: String
    var authrizationStatus: Bool
    var type: SocialNetworkType
}

enum SocialNetworkType {
    case vk
    case twitter
    case instagram
    case facebook
}
