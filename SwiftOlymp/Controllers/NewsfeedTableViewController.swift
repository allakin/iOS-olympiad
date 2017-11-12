//
//  NewsfeedTableViewController.swift
//  SwiftOlymp
//
//  Created by itisioslab on 11.11.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class NewsfeedTableViewController: UITableViewController {
    
    var news = [News]()
    let postCellIdentifier = "postCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        generateData()
    }
    
    //MARK: - Prepare methods
    
    func prepareTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        let postNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(postNib, forCellReuseIdentifier: postCellIdentifier)
    }
    
    func generateData() {
        let source = Source(name: "iOS Developer", avatarImageURL: URL(string: "vk.com")!)
        let vkNews1 = VkNews(source: source, date: Date(), text: "Post with text", imagesURL: nil, videosURL: nil, likeCount: 5, commentCount: 9, repostCount: 11, audiosURL: nil, links: nil)
        let vkNews2 = VkNews(source: source, date: Date(), text: nil, imagesURL: [(URL(string: "vk.com")!)], videosURL: nil, likeCount: 78, commentCount: 6, repostCount: 43, audiosURL: nil, links: nil)
        let vkNews3 = VkNews(source: source, date: Date(), text: "Post with text and Image", imagesURL: [(URL(string: "vk.com")!)], videosURL: nil, likeCount: 65, commentCount: 5, repostCount: 98, audiosURL: nil, links: nil)
        
        news.append(vkNews1)
        news.append(vkNews2)
        news.append(vkNews3)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: postCellIdentifier, for: indexPath) as! PostTableViewCell
        
        cell.prepareCell(with: news[indexPath.row])
        
        return cell
    }
}
