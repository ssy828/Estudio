//
//  ViewController.swift
//  Screen Transitions
//
//  Created by SSY on 2018. 5. 11..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    @IBAction func moveNextVC(_ sender: UIButton) {
        
        // 이동할 뷰 컨트롤러 객체를 스토리 보드 ID 정보를 참조하여 이동
       guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "secondVC") else { return }
        // 화면 전환할 애니메이션 타입
        nextVC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        // 인자값으로 뷰 컨트롤러 인스턴스를 넣고 프레젠트 메소드 호출
        self.present(nextVC, animated: true)
    }

}

