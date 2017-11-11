//
//  NewsLoader.swift
//  SwiftOlymp
//
//  Created by itisioslab on 11.11.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation
import VKSdkFramework

class NewsLoader {
    
    static func loadAllNews() -> [News] {
        
        return [News]()
    }
    
    static func loadVkNews() {
        let countRow = 20
        
        let getParameters: [String: Any] = ["filters": "post", "count": "\(countRow)"]
        if let request = VKRequest(method: "newsfeed.get", parameters: getParameters) {
            request.execute(resultBlock: { (response) in
                if let jsonResponse = response {
                    print(jsonResponse.json)
                    
                }
            }, errorBlock: { (error) in
                
            })
        }
    }
    
}
