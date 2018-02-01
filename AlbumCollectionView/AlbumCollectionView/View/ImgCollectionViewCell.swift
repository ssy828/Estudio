//
//  CustomCollectionViewCell.swift
//  AlbumCollectionView
//
//  Created by SSY on 2018. 1. 23..
import UIKit

class ImgCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImgView: UIImageView!
    
    var image: Img? {
        didSet{
            if let img = image{
                mainImgView.image = UIImage(named: img.name)
            }
        }
    }
   
}
