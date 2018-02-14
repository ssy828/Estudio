//
//  ViewController.swift
//  AlbumCollectionView
//
//  Created by SSY on 2018. 1. 23..

import UIKit
// MARK: - UIViewController
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
        configureNavigationBar()
    }
    // MARK: setEditing
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        navigationController?.isToolbarHidden = !editing
        collectionView.allowsMultipleSelection = editing
        if editing {
            editButtonItem.title = "Done"
            let indexPathList = collectionView.indexPathsForVisibleItems
            collectionView.allowsMultipleSelection = editing
            for index in indexPathList {
                let cell =
                    collectionView.cellForItem(at: index) as! ImgCollectionViewCell
                cell.isEditing = isEditing
            }
        } else {
            editButtonItem.title = "선택"
            collectionView.allowsSelection = false
        }

    }
    // MARK: change the layout the collectionView
    private func configureLayout() {
        let width = view.frame.size.width / 4
        let collectionLayout = collectionView.collectionViewLayout
            as! UICollectionViewFlowLayout
        collectionLayout.itemSize = CGSize(width: width, height: width)
    }
    // MARK: fetch up data
    private func fetchUpData() {
        ImageData.fetchUp { [weak self] response in
            guard let `self` = self else { return }
            print(response)
            self.imageData = response
        }
        // 데이터가 이쪽으로 어차피 넘어오질 못함. 변수에 담아두고 사용하질 않았음
        // [weak self] : self가 클로저에서 살아있는지 불확실한 경우
        // 명시적인 수명 연장 -> 옵셔널 언래핑([unowned self])보다 선호
        // guard let `self` = self else { return } : 객체 수명 연장
    }
    // MARK: editButtonItem
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = editButtonItem
        editButtonItem.title = "선택"
        navigationController?.isToolbarHidden = true
        
    }
}
// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    // MARK: numberOfSections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return imageData?.count ?? 0
    }
    // MARK: numberOfItemInSection
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return imageData?[section].items.count ?? 0
    }
    // MARK: cell
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                               for: indexPath) as! ImgCollectionViewCell
        cell.image = imageData?[indexPath.section].items[indexPath.item]
        cell.isEditing = isEditing
        return cell
    }
    // MARK: Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView =
            collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                            withReuseIdentifier: "SectionHeader",
                                                            for: indexPath) as! SectionHeader
        reusableView.categories = imageData?[indexPath.section]
        return reusableView
    }
    //MARK: didselectItem
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected: \(indexPath.item)")
    }
}
// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    
}
