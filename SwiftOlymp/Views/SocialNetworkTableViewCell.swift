//
//  SocialNetworkTableViewCell.swift
//  SwiftOlymp
//
//  Created by itisioslab on 11.11.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class SocialNetworkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var socialNetworkButton: UIButton!
    @IBOutlet weak var authorizationStatusLabel: UILabel!
    
    var authorizationDelegate: AuthorizationDelegate?
    var socialNetworkType: SocialNetworkType?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func prepareCell(with socialNetwork: SocialNetwork, and authorizationDelegate: AuthorizationDelegate) {
        let authorized = "Авторизован"
        let unathorized = "Неавторизован"
        
        socialNetworkButton.setTitle(socialNetwork.name, for: .normal)
        authorizationStatusLabel.text = (socialNetwork.authrizationStatus) ? authorized : unathorized
        self.authorizationDelegate = authorizationDelegate
        self.socialNetworkType = socialNetwork.type
    }
    
    @IBAction func onAuthorizationClick(_ sender: UIButton) {
        guard let socType = socialNetworkType else { return }
        authorizationDelegate?.authorize(with: socType)
    }
    
    
}
