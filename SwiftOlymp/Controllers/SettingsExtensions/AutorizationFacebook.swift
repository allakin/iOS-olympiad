//
//  AutorizationFacebook.swift
//  SwiftOlymp
//
//  Created by Дамир Зарипов on 12.11.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin

extension SettingsTableViewController {
    
    func authorizationFacebook() {
        loginButtonClicked()
    }
    
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [ReadPermission.publicProfile], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                UserDefaults.standard.set(accessToken, forKey: accessToken.authenticationToken)
                print("Logged in!")
            }
        }
        
    }
    
}


