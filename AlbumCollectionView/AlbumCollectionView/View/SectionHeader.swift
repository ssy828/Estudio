//
//  CustomCollectionReusableView.swift
//  AlbumCollectionView
//
//  Created by SSY on 2018. 2. 2..

import UIKit
// MARK: - SectionHeader
class SectionHeader: UICollectionReusableView {
    // IBOutlet
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    // property
    var categories: ImageModel? {
        didSet{
            if let category = categories {
                titleLB.text = category.title
            }
        }
    }
}
