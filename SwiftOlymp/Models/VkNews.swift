//
//  VkNews.swift
//  SwiftOlymp
//
//  Created by itisioslab on 11.11.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation

struct VkNews: News {
    var avatarImageURL: URL
    var name: String
    var date: Date
    var text: String?
    var imagesURL: [URL]?
    var videosURL: [URL]?
    var likeCount: Int
    var commentCount: Int
    var repostCount: Int
    var audiosURL: [URL]?
    var links: [URL]?
}
