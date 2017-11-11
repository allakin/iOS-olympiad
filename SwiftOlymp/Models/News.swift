//
//  News.swift
//  SwiftOlymp
//
//  Created by itisioslab on 11.11.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation

protocol News {
    var source: Source { get set }
    var date: Date { get set }
    var text: String? { get set }
    var imagesURL: [URL]? { get set }
    var videosURL: [URL]? { get set }
    var likeCount: Int { get set }
    var commentCount: Int { get set }
    var repostCount: Int { get set }
}
