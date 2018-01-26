//
//  ImageData .swift
//  AlbumCollectionView
//
//  Created by SSY on 2018. 1. 24..

import Foundation


struct Images: Decodable {
    
    let title: String
    let items: [Img]
    
    enum CodingKeys: String,CodingKey {
        case title = "Section_Title"
        case items
    }
}


struct Img: Decodable {
    
    let imageName: String
    
    enum CodingKeys: String,CodingKey {
        case imageName = "Image_Name"
    }
 
}


