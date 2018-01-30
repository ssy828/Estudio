//
//  ViewController.swift
//  AlbumCollectionView
//
//  Created by SSY on 2018. 1. 23..

import UIKit

class MainViewController: UIViewController {
    
    // MARK: property
    let cellId = "CustomCell"
    var imageData: [ImageModel]?
    
    // MARK: IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        fetchUpData()
    }
    
    // MARK: change the layout the collectionView
    private func configureLayout() {
        let width = view.frame.size.width / 4
        let collectionLayout = collectionView.collectionViewLayout
                                        as! UICollectionViewFlowLayout
        collectionLayout.itemSize = CGSize(width: width, height: width)
    }
    
    // MARK: fetch up data
    func fetchUpData() {
        ImageData.fetchUp()
    }
}
// MARK: -UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return imageData?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return imageData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = imageData?[indexPath.section].items[indexPath.item]
                                        else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                                      for: indexPath) as! ImgCollectionViewCell
        cell.configureImage(for: data)
        return cell
    }
    
    
}
// MARK: -UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    
}
