//
//  CustomCollectionReusableView.swift
//  AlbumCollectionView
//
//  Created by SSY on 2018. 2. 2..


import UIKit

class SectionHeader: UICollectionReusableView {
    
    @IBOutlet weak var titleLB: UILabel!
    
    @IBOutlet weak var categoryImageView: UIImageView!
    
    var categories: ImageModel? {
        didSet{
            if let category = categories {
                titleLB.text = category.title
            }
        }
    }
}
