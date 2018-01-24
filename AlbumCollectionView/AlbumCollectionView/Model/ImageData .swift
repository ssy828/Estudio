//
//  ImageData .swift
//  AlbumCollectionView
//
//  Created by SSY on 2018. 1. 24..
//  Copyright © 2018년 SONGYEE SHIN. All rights reserved.
//

import Foundation

struct Img {
    var title: String
    var imgNames: [String]
    
    func getImageDetail() -> String {
        return ""
    }
}

class ImageData {
    
   class func fetchImages() -> [Img] {
        var imageList: [Img] = []
        let imageData = ImageData.downloadphotoData()
        for (imageTitle, dictionary) in imageData {
            if let dic = dictionary as? [String: Any] {
                if let images = dic["imageNames"] as? [String] {
                // configuerImages -> [String]  반환하므로
                    let image = Img(title: imageTitle, imgNames: images)
                    imageList.append(image)
                }
            }
        }
        return imageList
    }
    
    class func downloadphotoData() -> [String: Any] {
        return ["Flowers": [ "imageNames" : ImageData.configuerImages("flower", number: 6)],
                "Cities": ["imageNames" : ImageData.configuerImages("kyoto", number: 1)]]
    }
    
   class func configuerImages(_ prefix: String,
                         number ofImg: Int ) -> [String] {
        var imageNames: [String] = []
        
        for index in 1...ofImg {
            imageNames.append("\(prefix)\(index)")
        }
        return imageNames
    }
}
