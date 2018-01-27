//
//  CustomCollectionViewCell.swift
//  AlbumCollectionView
//
//  Created by SSY on 2018. 1. 23..
import UIKit

class ImgCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImgView: UIImageView! 
    
    // MARK: configure cell image
    func configureImage(for cell: Img) {
        mainImgView.image = UIImage(named: cell.name)
    }
}
