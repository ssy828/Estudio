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
    var isEditing: Bool = false {
        didSet{
            selectionImgView.isHidden = !isEditing
        }
    }
    
    // isSelected
    override var isSelected: Bool {
        didSet{
            if isEditing {
                selectionImgView.image = isSelected ? UIImage(named: "icon2") : nil
            }
        }
    }
}
