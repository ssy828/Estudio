//
//  TodayViewController.swift
//  ContainerVC
//
//  Created by SSY on 2018. 5. 16..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 헤더뷰 nib 사용하므로 forHeaderFooterViewReuseIdentifier로 등록해야함!!
        self.tableView.register(CustomHeaderView.nib, forHeaderFooterViewReuseIdentifier: CustomHeaderView.identifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: viewWillAppear
    // viewDidLoad - 아직 뷰가 화면에 구현 되기 전 시점이므로
    // viewWillAppear에 설정하기
    override func viewWillAppear(_ animated: Bool) {
        // estimatedRowHeight - 임시로 사용할 셀의 높이
        self.tableView.estimatedRowHeight = 70
        // UITableViewAutomaticDimension - 테이블 뷰의 rowHeight 속성에 대입되어
        // 높입값을 동적으로 설정 될 것을 테이블 뷰에 알려주는 역할
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - UITableViewDataSource
extension TodayViewController: UITableViewDataSource {
    // MARK: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    // MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        return cell
        
    }
    // MARK: viewForHeaderInSection
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.identifier)

        return headerView
    }
    // MARK: heightForRowAt
    // 행의 높이
    // 헤더 높이 바꾸는 메소드 사용 - heightForHeaderInSection
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
   
}
// MARK: - UITableViewDelegate
extension TodayViewController: UITableViewDelegate {
    
}
