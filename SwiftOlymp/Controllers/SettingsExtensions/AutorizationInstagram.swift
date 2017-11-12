//
//  AutorizationInstagram.swift
//  SwiftOlymp
//
//  Created by BLVCK on 12/11/2017.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation
import UIKit

extension SettingsTableViewController {
    
    func authorizeInstagram() {
        
        performSegue(withIdentifier: "instagramLoginSeque", sender: nil)
        
    }
    
}



