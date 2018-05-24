//
//  MainViewController.swift
//  ContainerVC
//
//  Created by SSY on 2018. 5. 16..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: -IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: -properties
    lazy var yesterdayVC: YesterdayViewController = {
        // 스토리보드에서 인스턴스 생성
        let storyboard = UIStoryboard(name: "Yesterday", bundle: Bundle.main)
        // 뷰 컨트롤러에서 인스턴스 생성 - 스토리보드에서 가져오기
        let yesterdayVC = storyboard.instantiateViewController(withIdentifier: "YesterdayViewController") as! YesterdayViewController
        // 메인 뷰 컨트롤러에 자식 뷰 컨트롤러 추가
        // 이때 lazy 설정해줘야함
        self.addViewController(asChild: yesterdayVC)
        return yesterdayVC
    }()
    
    lazy var todayVC: TodayViewController = {
        let storyboard = UIStoryboard(name: "Today", bundle: Bundle.main)
        let todayVC = storyboard.instantiateViewController(withIdentifier: "TodayViewController") as! TodayViewController
        self.addViewController(asChild: todayVC)
        return todayVC
    }()
    
    // MARK: -IBAction
    @IBAction func didChangeValue(_ sender: UISegmentedControl) {
        updateView()
    }
    
    // MARK: -view Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }

    // MARK: - methods
    // 자식 뷰 추가하기
   private func addViewController(asChild viewController: UIViewController) {
        // 자식 뷰 컨트롤러 추가
        addChildViewController(viewController)
        // 자식 뷰 추가
        containerView.addSubview(viewController.view)
        // 제약 조건 맞추기
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        // 컨테이너 뷰에게 자식 뷰 알려주기
        viewController.didMove(toParentViewController: self)
    }
    
    // MARK: 자식 뷰 삭제하기
    private func removeViewController(asChild viewController: UIViewController) {
        // 자식 뷰 알리기
        viewController.willMove(toParentViewController: nil)
        // 제약 조건 & 루트 뷰에서 자식 뷰 제거
        viewController.view.removeFromSuperview()
        // 컨테이너 뷰에게 자식 뷰가 삭제 된 것을 알려주기
        viewController.removeFromParentViewController()
    }
    
    // MARK: update View
    private func updateView() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            removeViewController(asChild: yesterdayVC)
            addViewController(asChild: todayVC)
        case 1:
            removeViewController(asChild: todayVC)
            addViewController(asChild: yesterdayVC)
        default:
            break
        }
    }
    // MAKR: set up
    private func setUp() { self.updateView() }
    
}

