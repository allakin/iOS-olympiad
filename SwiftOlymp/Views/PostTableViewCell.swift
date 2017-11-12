//
//  PostTableViewCell.swift
//  SwiftOlymp
//
//  Created by itisioslab on 11.11.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit
import Kingfisher

class PostTableViewCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textContentLabel: UILabel!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var repostCountLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    @IBOutlet weak var avatarToCollectionConstraint: NSLayoutConstraint!
    @IBOutlet weak var textToLikeConstraint: NSLayoutConstraint!
    @IBOutlet weak var avatarToTextConstraint: NSLayoutConstraint!
    @IBOutlet weak var textToCollectionConstraint: NSLayoutConstraint!
    
    let photoCellIdentifier = "photoCollectionCellIdentifier"
    var photosURL = [URL]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registrCell()
        setDelegateAndDataSource()
        
    }

    func prepareCell(with news: News) {
        prepareConstraints(with: news)
        photosURL = news.imagesURL
        photoCollectionView.reloadData()
        
        let source = news.source
        avatarImageView.kf.setImage(with: source.avatarImageURL)
        nameLabel.text = source.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        dateLabel.text = dateFormatter.string(from: news.date)
        
        if let text = news.text {
            textContentLabel.text = text
        }
        likeCountLabel.text = String(news.likeCount)
        commentCountLabel.text = String(news.commentCount)
        repostCountLabel.text = String(news.repostCount)
        
        if news is VkNews {
            sourceLabel.text = "VK"
        } else if news is TwitterNews {
            sourceLabel.text = "Twitter"
        }
    }
   
    func registrCell(){
        let photoCellNib = UINib(nibName: "PhotoCustomCollectionViewCell", bundle: nil)
        photoCollectionView.register(photoCellNib, forCellWithReuseIdentifier: photoCellIdentifier)
    }
    
    func setDelegateAndDataSource() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
    }
    
    private func prepareConstraints(with news: News) {
        
        if news.text == nil, !news.imagesURL.isEmpty {
            textContentLabel.isHidden = true
            avatarToTextConstraint.priority = .defaultLow
            avatarToCollectionConstraint.priority = .defaultHigh
        }

        if news.text != nil, !news.imagesURL.isEmpty {
            textContentLabel.isHidden = false
            avatarToTextConstraint.priority = .defaultHigh
            avatarToCollectionConstraint.priority = .defaultLow
        }

        if news.text != nil, news.imagesURL.isEmpty {
            photoCollectionView.isHidden = true
            textToCollectionConstraint.priority = .defaultLow
            textToLikeConstraint.priority = .defaultHigh
        }
        if news.text != nil, !news.imagesURL.isEmpty {
            photoCollectionView.isHidden = false
            textToCollectionConstraint.priority = .defaultHigh
            textToLikeConstraint.priority = .defaultLow
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 140)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellIdentifier, for: indexPath) as! PhotoCustomCollectionViewCell
        cell.photoImageView.kf.setImage(with: photosURL[indexPath.row])
        return cell
    }
    
}
