//
//  CustomCollectionViewCell.swift
//  AlbumCollectionView
//
//  Created by SSY on 2018. 1. 23..
//  Copyright © 2018년 SONGYEE SHIN. All rights reserved.
//

import UIKit

class ImgCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImgView: UIImageView! 
    
    var imageName: String! {
        didSet {
            mainImgView.image = UIImage(named: imageName)
        }
    }
}
