//
//  PostTableViewCell.swift
//  SwiftOlymp
//
//  Created by itisioslab on 11.11.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textContentLabel: UILabel!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var repostCountLabel: UILabel!
    
    @IBOutlet weak var avatarToCollectionConstraint: NSLayoutConstraint!
    @IBOutlet weak var textToLikeConstraint: NSLayoutConstraint!
    @IBOutlet weak var avatarToTextConstraint: NSLayoutConstraint!
    @IBOutlet weak var textToCollectionConstraint: NSLayoutConstraint!
    
    let photoCellIdentifier = "photoCollectionCellIdentifier"
    var photos: [UIImage]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registrCell()
        setDelegateAndDataSource()
    }

    func prepareCell(with news: News) {
        prepareConstraints(with: news)
        
        let source = news.source
        //avatar
        nameLabel.text = source.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateLabel.text = dateFormatter.string(from: news.date)
        
        if let text = news.text {
            textContentLabel.text = text
        }
        //collectionView
        likeCountLabel.text = String(news.likeCount)
        commentCountLabel.text = String(news.commentCount)
        repostCountLabel.text = String(news.repostCount)
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
        if news.text == nil {
            textContentLabel.isHidden = true
            avatarToTextConstraint.priority = .defaultLow
            avatarToCollectionConstraint.priority = .defaultHigh
        } else {
            textContentLabel.isHidden = false
            avatarToTextConstraint.priority = .defaultHigh
            avatarToCollectionConstraint.priority = .defaultLow
        }
        
        if news.text != nil, news.imagesURL == nil {
            photoCollectionView.isHidden = true
            textToCollectionConstraint.priority = .defaultLow
            textToLikeConstraint.priority = .defaultHigh
        } else {
            photoCollectionView.isHidden = false
            textToCollectionConstraint.priority = .defaultHigh
            textToLikeConstraint.priority = .defaultLow
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellIdentifier, for: indexPath) as! PhotoCustomCollectionViewCell
        cell.prepareCell(with: photos[indexPath.row])
        return cell
    }
    
}
