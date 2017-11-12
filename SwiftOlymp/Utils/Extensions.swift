//
//  Extensions.swift
//  SwiftOlymp
//
//  Created by BLVCK on 11/11/2017.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
