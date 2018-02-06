//
//  CustomCollectionViewCell.swift
//  AlbumCollectionView
//
//  Created by SSY on 2018. 1. 23..
import UIKit

class ImgCollectionViewCell: UICollectionViewCell {
    
    // IBOutlet
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var selectionImgView: UIImageView!

    // Loading Image
    var image: Img? {
        didSet{
            if let img = image{
                mainImgView.image = UIImage(named: img.name)
            }
        }
    }
   
    // in case select photo
    var isSelecting: Bool = false {
        didSet{
            selectionImgView.isHidden = !isSelecting
        }
    }
    
    // isSelected
    override var isSelected: Bool {
        didSet{
            if isSelecting {
                selectionImgView.image = isSelected ? UIImage(named: "icon8") : nil
            }
        }
    }
}
