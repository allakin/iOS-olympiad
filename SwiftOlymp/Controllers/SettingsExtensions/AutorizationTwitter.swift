//
//  AutorizationTwitter.swift
//  SwiftOlymp
//
//  Created by BLVCK on 11/11/2017.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation
import Accounts
import Social
import SwifteriOS
import SafariServices

extension SettingsTableViewController: SFSafariViewControllerDelegate {
    
    
    func authorizeTwitter() {
        var swifter: Swifter
        
        let useACAccount = false
        
        swifter = Swifter(consumerKey: "RErEmzj7ijDkJr60ayE2gjSHT", consumerSecret: "SbS0CHk11oJdALARa7NDik0nty4pXvAxdt7aj0R5y1gNzWaNEx")
        
        let failureHandler: (Error) -> Void = { error in
            self.alert(title: "Error", message: error.localizedDescription)
            
        }
        
        if useACAccount {
            let accountStore = ACAccountStore()
            let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
            
            accountStore.requestAccessToAccounts(with: accountType, options: nil) { granted, error in
                guard granted else {
                    self.alert(title: "Error", message: error!.localizedDescription)
                    return
                }
                
                let twitterAccounts = accountStore.accounts(with: accountType)!
                
                if twitterAccounts.isEmpty {
                    self.alert(title: "Error", message: "There are no Twitter accounts configured. You can add or create a Twitter account in Settings.")
                } else {
                    let twitterAccount = twitterAccounts[0] as! ACAccount
                    swifter = Swifter(account: twitterAccount)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        } else {
            let url = URL(string: "swifter://success")!
            swifter.authorize(with: url, presentFrom: self, success: { _, _ in
                self.navigationController?.popViewController(animated: true)
            }, failure: failureHandler)
        }
    }
    
    @available(iOS 9.0, *)
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
