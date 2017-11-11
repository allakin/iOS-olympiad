//
//  NewsLoader.swift
//  SwiftOlymp
//
//  Created by itisioslab on 11.11.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation
import VKSdkFramework
import SwifteriOS

class NewsLoader {
    
    static func loadAllNews() -> [News] {
        
        return [News]()
    }
    
    static func loadVkNews() {
        let countRow = 20
        
        let getParameters: [String: Any] = ["filters": "post", "count": "\(countRow)"]
        if let request = VKRequest(method: "newsfeed.get", parameters: getParameters) {
            request.execute(resultBlock: { (response) in
                
            }, errorBlock: { (error) in
                
            })
        }
    }
    
    static func loadTwitterNews(with swifter: Swifter, completionBlock: @escaping ([TwitterNews]?) -> ()) {
        
        let failureHandler: (Error?) -> Void = { error in
            completionBlock(nil)
        }

        swifter.getHomeTimeline(count: 20, success: { json in
            guard let tweets = json.array else { return }
            prepareTwitterData(with: tweets, completionBlock: { (twittersNews) in
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
            //let dateJson = json["created_at"].string
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
            
            guard let tweetUrl = url else { return }
            
            guard let tweetAvatar = URL(string: tweetUrl) else { return }
            
            guard let tweetName = name else { return }
            
            guard let tweetText = text else { return }
            
            guard let tweetLikeCount = likeCount else { return }
            
            guard let tweetRepostCount = repostCount else { return }
            
            let date = Date()
            
            let tweet = TwitterNews(avatarImageURL: tweetAvatar, name: tweetName, date: date, text: tweetText, imagesURL: imagesURL, videosURL: videosURL, likeCount: Int(tweetLikeCount), commentCount: commentCount, repostCount: Int(tweetRepostCount), links: links)
            
            twitterNewsArray.append(tweet)
        
        }
        
        completionBlock(twitterNewsArray)
    }
}

