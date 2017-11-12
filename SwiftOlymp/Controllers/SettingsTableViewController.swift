//
//  SettingsTableViewController.swift
//  SwiftOlymp
//
//  Created by itisioslab on 11.11.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    let socialNetworks = [
        SocialNetwork(name: "VK", authrizationStatus: false, type: .vk),
        SocialNetwork(name: "Twitter", authrizationStatus: false, type: .twitter),
        SocialNetwork(name: "Facebook", authrizationStatus: false, type: .facebook),
        SocialNetwork(name: "Instagram", authrizationStatus: false, type: .instagram)
    ]
    let socialNetworkCellIdentifier = "socialNetworkCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
    }
    
    //MARK: - Prepare methods
    
    private func prepareTableView() {
        let socialNetworkNib = UINib(nibName: "SocialNetworkTableViewCell", bundle: nil)
        tableView.register(socialNetworkNib, forCellReuseIdentifier: socialNetworkCellIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return socialNetworks.count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: socialNetworkCellIdentifier, for: indexPath) as! SocialNetworkTableViewCell
            
            cell.prepareCell(with: socialNetworks[indexPath.row], and: self)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Социальные сети"
        }
        return nil
    }

}

extension SettingsTableViewController: AuthorizationDelegate {
    func authorize(with socialNetwork: SocialNetworkType) {
        switch socialNetwork {
        case .vk:
            authorizeVK()
        case .twitter:
            authorizeTwitter()
        case .facebook:
            authorizationFacebook()
        case .instagram:
            authorizationInstagram()
        }
    }
    
    func authorizeTwitter() {
        
    }
    
    func authorizationInstagram() {
        
    }
}






