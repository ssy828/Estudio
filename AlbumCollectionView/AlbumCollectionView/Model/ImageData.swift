//
//  ImageData.swift
//  AlbumCollectionView
//
//  Created by SSY on 2018. 1. 30..

import Foundation

struct ImageData {
    
    // MARK: fetch up
    static func fetchUp(completion:([ImageModel])->Void) {
        // 타입메소드: 인스턴스 생성하지 않고 사용가능
        guard let plistURL =
            Bundle.main.url(forResource: "ImagePropertyList",
                            withExtension: "plist") else { return }
        
        do {
            let data = try Data(contentsOf: plistURL)
            let plistDecoder = try PropertyListDecoder().decode([ImageModel].self, from: data)
            print(plistDecoder)
            completion(plistDecoder) // ***변수에 담은 데이터를 넘겨주기
        } catch (let error) {
            print("Erros:\(error.localizedDescription)")
        }
    }
}
