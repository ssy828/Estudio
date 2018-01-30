//
//  ImageData.swift
//  AlbumCollectionView
//
//  Created by SSY on 2018. 1. 30..

import Foundation

struct ImageData {
    
    // MARK: fetch up
    static func fetchUp() {
        guard let plistURL =
            Bundle.main.url(forResource: "ImagePropertyList",
                            withExtension: "plist") else { return }
        
        do {
            let data = try Data(contentsOf: plistURL)
            _ = try PropertyListDecoder().decode(ImageModel.self, from: data)
        } catch (let error) {
            print("Erros:\(error.localizedDescription)")
        }
        
    }
  
}
