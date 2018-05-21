//
//  TodayViewController.swift
//  ContainerVC
//
//  Created by SSY on 2018. 5. 16..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {

    var sections: [Section] = [
        Section(title: "Food Expense", items: ["breakfast","lunch","dinner"], isCollapsed: true),
        Section(title: "Transportaion Fee", items: ["bus","subway"], isCollapsed: true),
        Section(title: "Communication Fee", items: ["cellPhone","Ipad"], isCollapsed: true)
    ]
    
    
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

}
// MARK: - UITableViewDataSource
extension TodayViewController: UITableViewDataSource {
    // MARK: numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    // MARK: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !sections[section].isCollapsed {
           return 0
        }
        
        return sections[section].items.count
    }
    // MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        let itemTitle = sections[indexPath.section].items[indexPath.row]
        cell.titleLb?.text = itemTitle
        return cell
        
    }
    // MARK: viewForHeaderInSection
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.identifier) as! CustomHeaderView
        headerView.categoryTitleLabel.text = sections[section].title
        headerView.openCloseButton.addTarget(self, action: #selector(handleExpandedClose), for: .touchUpInside)
        headerView.openCloseButton.tag = section
        return headerView
    }
    // MARK: - @objc func handleExpandedClose
    @objc func handleExpandedClose(_ button: UIButton) {
        let section = button.tag
        var indexPaths = [IndexPath]()
        // indices - 집합의 하위 문자열에 유효한 인덱스를 오름차순으로 나타내는 유형
        // 유효한 값의 범위를 가짐
        for item in sections[section].items.indices{
            let indexPath = IndexPath(row: item, section: section)
            indexPaths.append(indexPath)
        }
        let isCollapsed = sections[section].isCollapsed
        sections[section].isCollapsed = !isCollapsed
        
        button.setTitle(isCollapsed ? "Open" : "Close" , for: .normal)
        
        if isCollapsed {
             self.tableView.deleteRows(at: indexPaths, with: .fade)
        }else{
          self.tableView.insertRows(at: indexPaths, with: .fade)
        }
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
