//
//  CategoryViewController.swift
//  ContainerVC
//
//  Created by SSY on 2018. 7. 12..
//  Copyright © 2018년 LittleMe. All rights reserved.
//
//
//import UIKit
//
//class CategoryViewController: UIViewController {
//    
//    // MARK: Properties
//    static var identifier: String {
//        return String(describing: self)
//    }
//    private var isClicked: Bool = true // 버튼 눌렀을 경우
//    public var didAddHandler: ((UIColor?,String?) -> Void)? // 버튼 색과 버튼 타이트 값 넘겨줄 클로저
//    private var section: Section?
//    private var buttonColor: UIColor?
//    private var buttonTitle: String?
//    // MARK: IBAction
//    @IBAction func didTapColorButton(_ sender: UIButton) {
//        if isClicked {
//            sender.setImage(#imageLiteral(resourceName: "icons8-checkmark-24"), for: .normal)
//            isClicked = !isClicked
//        }else{
//            sender.setImage(nil, for: .normal)
//            isClicked = !isClicked
//        }
//        self.buttonColor = sender.backgroundColor
//        self.buttonTitle = sender.titleLabel?.text
//    }
//    
//    @IBAction func didTapSaveButton(_ sender: UIBarButtonItem) {
//        if let buttonColor = buttonColor, let buttonTitle = buttonTitle {
//                self.section?.color = buttonColor
//                self.didAddHandler?(buttonColor,buttonTitle)
//        }
//        self.navigationController?.popViewController(animated: false)
//    }
//    
//    
//    // MARK: Life Cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Do any additional setup after loading the view.
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    
//    /*
//     // MARK: - Navigation
//     
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destinationViewController.
//     // Pass the selected object to the new view controller.
//     }
//     */
//    
//}
