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

class NewsfeedTableViewController: UITableViewController {
    
    var news = [News]()
    
    var tweets : [JSON] = []
    let reuseIdentifier: String = "reuseIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PostTableViewCellIdentifier")
        print(tweets[0])
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCellIdentifier", for: indexPath) as! PostTableViewCell
        cell.tweetTextLabel.text = tweets[indexPath.row]["text"].string
        cell.tweetDetailTextLabel.text = "By \(tweets[indexPath.row]["user"]["name"].string!), @\(tweets[indexPath.row]["user"]["screen_name"].string!)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

}
