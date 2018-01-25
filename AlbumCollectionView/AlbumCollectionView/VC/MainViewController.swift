//
//  ViewController.swift
//  AlbumCollectionView
//
//  Created by SSY on 2018. 1. 23..


import UIKit

class MainViewController: UIViewController {
    
    // MARK: property
    let cellId = "CustomCell"
    var imageCollection = [UIImage]()
//    var images: [Img] = ImageData.fetchImages()
    
    // MARK: IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // ToDo: change the layout the collectionView
        let width = view.frame.size.width / 4
        let collectionLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        collectionLayout.itemSize = CGSize(width: width, height: width)
    }
    
    
}
// MARK: -UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let indexSection = indexPath.section
        let indexItem = indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImgCollectionViewCell
       
        
        return cell
    }
    
    
}
// MARK: -UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    
}
