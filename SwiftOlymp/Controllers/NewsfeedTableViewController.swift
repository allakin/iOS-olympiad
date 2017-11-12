//
//  NewsfeedTableViewController.swift
//  SwiftOlymp
//
//  Created by itisioslab on 11.11.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit
import SwifteriOS
import SafariServices

class NewsfeedTableViewController: UITableViewController, ReloadDataDelegate {
    
    var news = [News]()
    
    var tweets : [JSON] = []
    let reuseIdentifier: String = "reuseIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PostTableViewCellIdentifier")
        //print(tweets[0])
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    //MARK: - Work with delegate
    func reloadData(with helper: Any?, and type: SocialNetworkType) {
        if type == .twitter {
            guard let swifter = helper as? Swifter else { return }
            NewsLoader.loadTwitterNews(with: swifter, completionBlock: { (tweets) in
                
            })
        }
    }

}
