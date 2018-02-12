//
//  CustomCollectionViewCell.swift
//  AlbumCollectionView
//
//  Created by SSY on 2018. 1. 23..
import UIKit
// MARK: - CollectionViewCell
class ImgCollectionViewCell: UICollectionViewCell {
    
    // IBOutlet
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var selectionImgView: UIImageView!

    // property
    // Loading Image
    public var image: Img? {
        didSet{
            if let img = image{
                mainImgView.image = UIImage(named: img.name)
            }
        }
    }
    
    // in case select photo
    public var isEditing: Bool = false {
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
