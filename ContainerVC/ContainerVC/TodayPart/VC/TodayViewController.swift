//
//  TodayViewController.swift
//  ContainerVC
//
//  Created by SSY on 2018. 5. 16..
//  Copyright © 2018년 LittleMe. All rights reserved.
//
import UIKit

class TodayViewController: UIViewController {
    
    // MARK: - properties
    var sections: [Section] = [
        Section(title: "Food Expense", items: ["breakfast","lunch","dinner"], isCollapsed: true),
        Section(title: "Transportaion Fee", items: ["bus","subway"], isCollapsed: true),
        Section(title: "Communication Fee", items: ["cellPhone","Ipad"], isCollapsed: true)
    ]
    private var data = [Category]()
    
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
        self.tableView.estimatedRowHeight = 50
        // UITableViewAutomaticDimension - 테이블 뷰의 rowHeight 속성에 대입되어
        // 높입값을 동적으로 설정 될 것을 테이블 뷰에 알려주는 역할
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
}
// MARK: - UITableViewDataSource
extension TodayViewController: UITableViewDataSource {
    // MARK: numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    // MARK: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let isCollapsed = sections[section].isCollapsed
        let isCollapsed = data[section].isCollapsed
        return isCollapsed ? data[section].items.count : 0
    }
    // MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        let items = data[indexPath.section].items[indexPath.row]
//        let itemTitle = sections[indexPath.section].items[indexPath.row]
        cell.titleLb.text = items.content
        cell.moneyLb.text = items.amount
        return cell
        
    }
    // MARK: viewForHeaderInSection
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.identifier) as! CustomHeaderView
//        headerView.categoryTitleLabel.text = sections[section].title
        headerView.categoryTitleLabel.text = data[section].title
        headerView.openCloseButton.tag = section // 섹션을 버튼 태그에 넣음
        headerView.delegate = self // 델리게이튼 패턴 사용시 무조건 필요!!
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Today", bundle: Bundle.main)
        let detailVC = storyboard.instantiateViewController(withIdentifier: ModifiedPostSuperViewController.identifier)
        self.navigationController?.pushViewController(detailVC, animated: false)
        tableView.deselectRow(at: indexPath, animated: false) // 선택한 줄에서 선택 표시 지움
    }
}
// MARK: - CustomHeaderViewDelegate
extension TodayViewController: CustomHeaderViewDelegate {
    // Toggle collapse
    func toggleSection(_ button: UIButton) {
        let section = button.tag
        var indexPaths = [IndexPath]()
//        let isCollapsed = sections[section].isCollapsed
        let isCollapsed = data[section].isCollapsed
//        sections[section].isCollapsed = !isCollapsed
        data[section].isCollapsed = !isCollapsed // isCollpase의 반대를 넣어줌
        button.setTitle(isCollapsed ? "Open" : "Close", for: .normal) // 버튼 타이틀 변경
        // indices - 집합의 하위 문자열에 유효한 인덱스를 오름차순으로 나타내는 유형
        // 유효한 값의 범위를 가짐
//        for item in sections[section].items.indices {
        for item in data[section].items.indices {
            let indexPath = IndexPath(row: item, section: section)
            indexPaths.append(indexPath)
        }
        // isCollpase가 true - deleteRows / false - insertRows
        isCollapsed ? tableView.deleteRows(at: indexPaths, with: .fade) : tableView.insertRows(at: indexPaths, with: .fade)
    }
}
