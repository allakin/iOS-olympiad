//
//  AuthorizationDelegate.swift
//  SwiftOlymp
//
//  Created by itisioslab on 11.11.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation

protocol AuthorizationDelegate {
    func authorize(with socialNetwork: SocialNetworkType)
}
