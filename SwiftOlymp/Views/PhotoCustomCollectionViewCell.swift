//
//  PhotoCustomCollectionViewCell.swift
//  SwiftOlymp
//
//  Created by Тимур Шафигуллин on 12.11.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class PhotoCustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    func prepareCell(with photo: UIImage){
        photoImageView.image = photo
    }
}
