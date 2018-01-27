//
//  ImageData .swift
//  AlbumCollectionView
//
//  Created by SSY on 2018. 1. 24..

import Foundation
// MARK: 이미지 데이터 모델
struct ImageData: Decodable {
    let title: String
    let items: [Img]
    
    // MARK: Cordingkeys
    // - A type that can be used as a key for encoding and decoding.
    enum CodingKeys: String,CodingKey {
        case title = "Section_Title"
        case items
    }
}
// MARK: 1개의 이미지 데이터
struct Img: Decodable {
    let name: String
    // MARK: key - String 이므로 [rawvalue 타입 - String 타입]
    enum CodingKeys: String,CodingKey {
        case name = "Image_Name"
    }
}


