//
//  ColorPickerTableViewCell.swift
//  ContainerVC
//
//  Created by SSY on 2018. 8. 5..
//  Copyright © 2018년 LittleMe. All rights reserved.
//
import UIKit

class ColorPickerTableViewCell: UITableViewCell {
    // MARK: Properties
    private var colorPickerArray = [UIColor?]()
    private var titleArray = [String?]()
    public var didAddHandler: ((UIColor?,String?) -> Void)?
    // MARK: IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.colorPickerArray = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]
        self.titleArray =  ["식비","교통비", "통신", "저축", "쇼핑","생활용품","의료","교육"]
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
// MARK: - UICollectionViewDataSource
extension ColorPickerTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.colorPickerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CustomCollectionViewCell
        collectionCell.colorLabel.backgroundColor = self.colorPickerArray[indexPath.item]
        collectionCell.colorLabel.text = self.titleArray[indexPath.item]
        return collectionCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ColorPickerTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexPathItem = indexPath.item
        let color = self.colorPickerArray[indexPathItem]
        let text = self.titleArray[indexPathItem]
        self.didAddHandler?(color,text)
        print("\(color),\(text)")
    }
    
}
