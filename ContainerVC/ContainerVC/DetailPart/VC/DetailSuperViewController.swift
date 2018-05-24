//
//  DetailSuperViewController.swift
//  ContainerVC
//
//  Created by SSY on 2018. 5. 23..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit

class DetailSuperViewController: UIViewController {
    // MARK: Properties
    static var identifier: String {
        return String(describing: self)
    }
    // 디테일 뷰컨트롤러 인스턴스
    lazy var detailVC: DetailTableViewController = {
        let storyboard = UIStoryboard(name: "Today", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: DetailTableViewController.identifier) as! DetailTableViewController
        self.addChildViewController(detailVC)
        return detailVC
    }()
    // Methods
    // MARK: addViewController
    private func addViewController(asChild viewController: UIViewController) {
        // 자식 뷰 컨트롤러 추가
        addChildViewController(viewController)
        // 자식 뷰 추가
        containerView.addSubview(viewController.view)
        // 제약 조건 맞추기
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        // 컨테이너 뷰에게 자식 뷰 알려주기
        viewController.didMove(toParentViewController: self)
    }
    // MARK: removeViewController
    private func removeViewController(asChild viewController: UIViewController) {
        // 자식 뷰 알리기
        viewController.willMove(toParentViewController: nil)
        // 제약 조건 & 루트 뷰에서 자식 뷰 제거
        viewController.view.removeFromSuperview()
        // 컨테이너 뷰에게 자식 뷰가 삭제 된 것을 알려주기
        viewController.removeFromParentViewController()
    }
    // MARK: setUpView
    private func setUpView() {
        addViewController(asChild: detailVC)
//        removeViewController(asChild: detailVC)
    }
    
    // MARK: IBOutlet
    @IBOutlet weak var containerView: UIView!

    // MARK: IBAction
    @IBAction func backToTodayVC(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }

}
