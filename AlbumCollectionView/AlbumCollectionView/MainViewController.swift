//
//  ViewController.swift
//  AlbumCollectionView
//
//  Created by SSY on 2018. 1. 23..
//  Copyright © 2018년 SONGYEE SHIN. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: property
    let cellId = "CustomCell"
    var imageCollection = [UIImage]()
    
    // MARK: IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollection.append(UIImage(named: "loveme")!)
        imageCollection.append(UIImage(named: "loveme")!)
        imageCollection.append(UIImage(named: "loveme")!)
        imageCollection.append(UIImage(named: "loveme")!)
        imageCollection.append(UIImage(named: "loveme")!)
        imageCollection.append(UIImage(named: "loveme")!)
        imageCollection.append(UIImage(named: "loveme")!)
        imageCollection.append(UIImage(named: "loveme")!)
        imageCollection.append(UIImage(named: "loveme")!)
        imageCollection.append(UIImage(named: "loveme")!)
        imageCollection.append(UIImage(named: "loveme")!)
        imageCollection.append(UIImage(named: "loveme")!)
        imageCollection.append(UIImage(named: "loveme")!)
        imageCollection.append(UIImage(named: "loveme")!)
        imageCollection.append(UIImage(named: "loveme")!)
        imageCollection.append(UIImage(named: "loveme")!)
        imageCollection.append(UIImage(named: "loveme")!)
        imageCollection.append(UIImage(named: "loveme")!)
        let width = view.frame.size.width / 4
        let collectionLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        collectionLayout.itemSize = CGSize(width: width, height: width)
    }
    
    
}
// MARK: -UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImgCollectionViewCell
        
        cell.mainImgView.image = imageCollection[index]
        
        return cell
    }
    
    
}
// MARK: -UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    
}
