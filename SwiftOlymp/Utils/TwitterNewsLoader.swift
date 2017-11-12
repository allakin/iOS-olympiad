//
//  TwitterNewsLoader.swift
//  SwiftOlymp
//
//  Created by BLVCK on 12/11/2017.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation
import SwifteriOS

class TwitterNewsLoader {
    
static func loadTwitterNews(with swifter: Swifter, completionBlock: @escaping ([TwitterNews]?) -> ()) {
    
    let failureHandler: (Error?) -> Void = { error in
        completionBlock(nil)
    }
    
    swifter.getHomeTimeline(count: 20, success: { json in
        guard let tweets = json.array else { return }
        self.prepareTwitterData(with: tweets, completionBlock: { (twittersNews) in
            completionBlock(twittersNews)
        })
    }, failure: failureHandler)
    
}

private static func prepareTwitterData(with json: [JSON], completionBlock: @escaping ([TwitterNews]?) -> ()) {
    
    var twitterNewsArray = [TwitterNews]()
    var imagesURL = [URL]()
    
    json.forEach { (json) in
        let url = json["user"]["profile_image_url"].string
        let name = json["user"]["name"].string
        let dateJson = json["created_at"].string
        let text =  json["text"].string
        let imagesURLJson = json["extended_entities"]["media"].array
        let videosURL: [URL]? = nil
        let likeCount = json["favorite_count"].double
        let commentCount = 21
        let repostCount = json["retweet_count"].double
        let links: [URL]? = nil
        
        if let mediaArray = imagesURLJson {
            for media in mediaArray {
                guard let stringURL = media["media_url_https"].string else { return }
                guard let tweetMedia = URL(string: stringURL) else { return }
                imagesURL.append(tweetMedia)
            }
        }
        
        let dateFormatter = DateFormatter()
        //dateFormatter.date(from: "EEE MMM dd HH:mm:ss Z yyyy")
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        let tweetDate = dateFormatter.date(from: dateJson!)
        
        
        guard let tweetUrl = url else { return }
        
        guard let tweetAvatar = URL(string: tweetUrl) else { return }
        
        guard let tweetName = name else { return }
        
        guard let tweetText = text else { return }
        
        guard let tweetLikeCount = likeCount else { return }
        
        guard let tweetRepostCount = repostCount else { return }
        
        let source = Source(name: tweetName, avatarImageURL: tweetAvatar)
        
        //let date = Date()
        
        let tweet = TwitterNews(source: source, date: tweetDate!, text: tweetText, imagesURL: imagesURL, videosURL: videosURL, likeCount: Int(tweetLikeCount), commentCount: commentCount, repostCount: Int(tweetRepostCount), links: links)
        
        twitterNewsArray.append(tweet)
        
    }
    
        completionBlock(twitterNewsArray)
    }
}
