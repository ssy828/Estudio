//
//  TodayListViewController.swift
//  ContainerVC
//
//  Created by SSY on 2018. 5. 16..
//  Copyright © 2018년 LittleMe. All rights reserved.
//
import UIKit

class TodayListViewController: UIViewController {
    
    // viewController segue Identifier
    enum ViewControllerState: String {
        case editing = "Editing"
        case posting = "Posting"
    }
    
    // MARK: - properties
    private var datasource = [Section]()
    var filtered = [Section]()
    //    private var sorted = [Section]()
    // MARK: - IBOutlet
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // 임시로 만든 버튼 새롭게 글쓰기 포스팅하려고
    @IBAction func newButton(_ sender: UIButton){ }
    
    // MARK: - Methods
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 헤더뷰 nib 사용하므로 forHeaderFooterViewReuseIdentifier로 등록해야함!!
        self.tableView.register(CustomHeaderView.nib,
                                forHeaderFooterViewReuseIdentifier: CustomHeaderView.identifier)
        
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
    // MARK: prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 중간에 내비게이션이 있는 상태이므로
        if let navigationVC = segue.destination as? UINavigationController,
            let detailVC = navigationVC.viewControllers.first as? PostTableViewController {
            switch segue.identifier {
            case ViewControllerState.posting.rawValue:
                detailVC.didAddHandler = { [weak self] (data) in
                    guard let `self` = self else { return }
                    // 카테고리 제목끼리 같은 경우
                    if self.datasource.contains(where: { (section) -> Bool in
                        return section.title == data.title
                    }){
                        self.datasource = self.datasource.map({ (item) in
                            if item.title == data.title{
                                var item = item
                                item.items.append(contentsOf: data.items)
                                return item
                            }
                            return item
                        })
                    }else{ // 카테고리 제목이 다른 경우
                        self.datasource.append(data)// 전체 데이터 추가
                    }
                    self.tableView.reloadData()
                }
            case ViewControllerState.editing.rawValue:
                if let indexPath =
                    tableView.indexPath(for: sender as! CustomTableViewCell) {
                    detailVC.itemToEdit = datasource[indexPath.section]
                    detailVC.itemToEdit?.items = datasource[indexPath.section].items
                }
            default:
                return
                
            }
        }
    }
}
// MARK: - UITableViewDataSource
extension TodayListViewController: UITableViewDataSource {
    // MARK: numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.count
    }
    // MARK: numberOfRowsInSection
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        //        let isCollapsed = datasource[section].isCollapsed
        //        //        detailData = category[section].items
        //        //        return isCollapsed ? detailData.count : 0
        //        return isCollapsed ? datasource[section].items.count: 0
        return datasource[section].items.count
    }
    // MARK: cellForRowAt
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell",
                                                 for: indexPath) as! CustomTableViewCell
        let section = self.datasource[indexPath.section]
        let item = section.items[indexPath.row]
        cell.titleLb.text = item.content
        cell.moneyLb.text = item.amount
        return cell
        
    }
    // MARK: viewForHeaderInSection
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView =
            tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.identifier) as! CustomHeaderView
        headerView.categoryTitleLabel.text = datasource[section].title.rawValue
        headerView.openCloseButton.tag = section // 섹션을 버튼 태그에 넣음
        headerView.delegate = self // 델리게이튼 패턴 사용시 무조건 필요!!
        return headerView
    }
    // MARK: heightForRowAt
    // 행의 높이
    // 헤더 높이 바꾸는 메소드 사용 - heightForHeaderInSection
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
// MARK: - UITableViewDelegate
extension TodayListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        //                let index = indexPath.row
        //                let item = category[index]
        //                postTableView.didAddHandler?(item)
        tableView.deselectRow(at: indexPath, animated: false) // 선택한 줄에서 선택 표시 지움
    }
}
// MARK: - CustomHeaderViewDelegate
extension TodayListViewController: CustomHeaderViewDelegate {
    // Toggle collapse
    func toggleSection(_ button: UIButton) {
        //        let section = button.tag
        //        var indexPaths = [IndexPath]()
        //        let isCollapsed = datasource[section].isCollapsed
        //        datasource[section].isCollapsed = !isCollapsed // isCollpase의 반대를 넣어줌
        //        button.setTitle(isCollapsed ? "Open" : "Close", for: .normal) // 버튼 타이틀 변경
        //        // indices - 집합의 하위 문자열에 유효한 인덱스를 오름차순으로 나타내는 유형
        //        // 유효한 값의 범위를 가짐
        //        for item in datasource[section].items.indices {
        //            let indexPath = IndexPath(row: item, section: section)
        //            indexPaths.append(indexPath)
        //        }
        //        // isCollpase가 true - deleteRows / false - insertRows
        //        isCollapsed ?
        //            tableView.deleteRows(at: indexPaths, with: .fade) :
        //            tableView.insertRows(at: indexPaths, with: .fade)
    }
}
