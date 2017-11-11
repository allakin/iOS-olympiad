//
//  TwitterNews.swift
//  SwiftOlymp
//
//  Created by BLVCK on 11/11/2017.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation

struct TwitterNews: News {
    var avatarImageURL: URL
    var name: String
    var date: Date
    var text: String?
    var imagesURL: [URL]?
    var videosURL: [URL]?
    var likeCount: Int
    var commentCount: Int
    var repostCount: Int
    var links: [URL]?
}
