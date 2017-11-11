//
//  AutorizationVK.swift
//  SwiftOlymp
//
//  Created by itisioslab on 11.11.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation
import VKSdkFramework

extension SettingsTableViewController: VKSdkDelegate, VKSdkUIDelegate {
    func authorizeVK() {
        let scope = ["friends", "wall"]
        
        if let sdk = VKSdk.initialize(withAppId: "6255106") {
            sdk.register(self)
            sdk.uiDelegate = self
        }
        
        VKSdk.wakeUpSession(scope) { (state, error) in
            switch state {
            case .authorized:
                print("Authorized succesfull")
                break
            case .initialized:
                VKSdk.authorize(scope)
                break
            case .error:
                //alert
                print("Alert error")
                break
            default:
                break
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print("End authorization, reload data")
        navigationController?.popViewController(animated: true)
    }
    
    func vkSdkUserAuthorizationFailed() {
        print("Error authrization in server")
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        present(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
    
    
}
