//
//  NewsLoader.swift
//  SwiftOlymp
//
//  Created by itisioslab on 11.11.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation
import VKSdkFramework
import SwiftyJSON

class NewsLoader {
    
    static func loadAllNews() -> [News] {
        
        return [News]()
    }
    
    static func loadVkNews(completionBlock: @escaping ([VkNews]?) -> ()) {
        let countRow = 20
        
        let getParameters: [String: Any] = ["filters": "post", "count": "\(countRow)"]
        if let request = VKRequest(method: "newsfeed.get", parameters: getParameters) {
            request.execute(resultBlock: { (response) in
                if let jsonResponse = response {
                    print(jsonResponse.json)
                    let json = JSON(jsonResponse.json)
                    completionBlock(prepareVkData(with: json))
                }
            }, errorBlock: { (error) in
                completionBlock(nil)
            })
        }
    }
    
    private static func prepareVkData(with json: JSON) -> [VkNews] {
        var vkNewsArray = [VkNews]()
        let itemsJSON = json["items"].arrayValue
        var sources = [Int: Source]()
        
        let profilesJSON = json["profiles"].arrayValue
        for profileJSON in profilesJSON {
            let profileID = profileJSON["id"].intValue
            let profileName = profileJSON["fisrt_name"].stringValue
            let profileSurname = profileJSON["last_name"].stringValue
            let photoUrlString = profileJSON["photo_100"].stringValue
            guard let photoURL = URL(string: photoUrlString) else { continue }
            
            let name = "\(profileName) \(profileSurname)"
            let source = Source(name: name, avatarImageURL: photoURL)
            sources[profileID] = source
        }
        
        let groupsJSON = json["groups"].arrayValue
        for groupJSON in groupsJSON {
            let groupID = groupJSON["id"].intValue
            let groupName = groupJSON["name"].stringValue
            let photoUrlString = groupJSON["photo_100"].stringValue
            guard let photoURL = URL(string: photoUrlString) else { continue }
            
            let source = Source(name: groupName, avatarImageURL: photoURL)
            sources[groupID] = source
        }
        
        for itemJSON in itemsJSON {
            var imagesURL = [URL]()
            
            let sourceID = abs(itemJSON["source_id"].intValue)
            let dateUnixTime = itemJSON["date"].intValue
            let text = itemJSON["text"].string
            let likeCount = itemJSON["likes"]["count"].intValue
            let commentCount = itemJSON["comments"]["count"].intValue
            let repostCount = itemJSON["reposts"]["count"].intValue
            
            let attachmentsJSON = itemJSON["attachments"].arrayValue
            for attachmentJSON in attachmentsJSON {
                if attachmentJSON["type"].stringValue == "photo" {
                    let imageStringURL = attachmentJSON["photo"]["photo_604"].stringValue
                    if let imageURL = URL(string: imageStringURL) {
                        imagesURL.append(imageURL)
                    }
                }
            }
            
            guard let source = sources[sourceID] else { continue }
            let date = Date(timeIntervalSince1970: TimeInterval(dateUnixTime))
            let vkNews = VkNews(source: source, date: date, text: text, imagesURL: imagesURL, videosURL: nil, likeCount: likeCount, commentCount: commentCount, repostCount: repostCount, audiosURL: nil, links: nil)
            vkNewsArray.append(vkNews)
        }
        
        return vkNewsArray
    }
    
}
