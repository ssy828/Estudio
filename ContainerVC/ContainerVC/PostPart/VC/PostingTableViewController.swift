//
//  PostingTableViewController.swift
//  ContainerVC
//
//  Created by SSY on 2018. 8. 20..
//  Copyright © 2018년 LittleMe. All rights reserved.
//
import UIKit

class GlobalUIViewController: UIViewController {
    
}

class GlobalTableCell: UITableViewCell {
    
}

class PostData {
    var date: Date?
    var title: String = ""
    var price: String = ""
}

//MARK: UITableViewController
class PostingTableViewController: UITableViewController {
    
    var dataSource: PostData? {
        didSet {
            self.tableView.reloadData()
        }
    }
    // 셀 타입
    enum PostSection: Int {
        case title
        case price
        case colorPicker
        case date
        case datePicker
        case text
        case count

        var rowCount: Int {
            get {
                switch self {
                    // case에 따른 개수
                default:
                    return 1
                }
            }
        }
        
//        func getCellData() -> Any? {
//            switch self {
//            case .title, .price:
//                break
//            default:
//                break
//            }
//        }
        func getCellType() -> UITableViewCell.Type {
            switch self {
            case .title, .price:
                return ContentTableViewCell.self
                // PriceTableViewCell
            case .colorPicker:
                return ColorPickerTableViewCell.self
            case .datePicker:
                return DateTableViewCell.self
            case .text:
                return TextViewTableViewCell.self
            default:
                return UITableViewCell.self
            }
        }
    }
    
    // MARK: properties
    // 타입추론 하는데도 시간이 오래걸리니 타입을 써줄 것!
    private var isHiddenDatePicker: Bool = false
    public var didAddHandler:((Section) -> Void)? // 클로저를 통해 데이터 넘기기
    public var itemsToEdit: Section?
    public var items: DetailData?
    public var colorText: String?
    public var amount: String?
    public var contents: String?
    public var color: UIColor?
    // MARK: IBAction
    @IBAction func didClickUndo(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }
    // 확인 눌렀을 경우
    @IBAction func didClickDone(_ sender: UIBarButtonItem) {
        guard let contents = self.contents, let amount = self.amount else { return }
        if let categoryTitle = colorText, let title = CategoryTitle(rawValue: categoryTitle) {
            let item = DetailData(content: contents, amount: amount)
            let section = Section(title: title, items: [item], color: color!)
            self.didAddHandler?(section)
        }
        self.dismiss(animated: false, completion: nil)
    }
    
    // MARK: - Methods
    func toggleDatepicker() {
        self.isHiddenDatePicker = !isHiddenDatePicker
        // 현재 데이트 피커의 상태를 넣어줌
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.toggleDatepicker()
        
        self.tableView.register(UITableViewCell.self)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return PostSection.count.rawValue
    }
    // MARK: numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = PostSection(rawValue: section) else { return 0 }
        return section.rowCount
    }
  
    // MARK: cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = PostSection(rawValue: indexPath.section) else {
            return tableView.dequeueReusableCell(UITableViewCell.self, for: indexPath)
        }
        switch section {
        case .title:
            let cell = tableView.dequeueReusableCell(ContentTableViewCell.self, for: indexPath)
            cell.delegate = self
            return cell
        case .price:
            let cell = tableView.dequeueReusableCell(ContentTableViewCell.self, for: indexPath)
            cell.delegate = self
            return cell
        case .colorPicker:
            let cell = tableView.dequeueReusableCell(ColorPickerTableViewCell.self, for: indexPath)
            cell.didAddHandler = { [weak self] (color,text) in
                guard let `self` = self else {return}
                self.color = color
                self.colorText = text
            }
            return cell
        case .date:
            let cell = tableView.dequeueReusableCell(UITableViewCell.self, for: indexPath)
            // cell.detailTextLabel?.text = dataSource?.date.toString()
            return cell
        case .datePicker:
            let cell = tableView.dequeueReusableCell(DateTableViewCell.self, for: indexPath)
            // cell.data = section.getCellData() as? DateData
            cell.delegate = self
            return cell
        case .text:
            let cell = tableView.dequeueReusableCell(TextViewTableViewCell.self, for: indexPath)
            return cell
        default:
            return tableView.dequeueReusableCell(UITableViewCell.self, for: indexPath)
        }
    }
    // MARK: heightForRowAt
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        let row = indexPath.row
        if isHiddenDatePicker && section == 1 && row == 2 {
            return 0
        }else {
            switch (section, row) {
            case (1,2),(2,0):
                return 100
            default:
                return super.tableView(tableView, heightForRowAt: indexPath)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (1,1):
            self.toggleDatepicker()
        default:
            break
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

// MARK: - DateTableViewCellDelegate
extension PostingTableViewController: DateTableViewCellDelegate {
//    func pass(date: String, dateCell: UITableViewCell) {
//        dateCell.detailTextLabel?.text = date
//    }
    func pass(date: String) {
//        self.dataSource?.date = date
        // To input date in detailTextLabel of cell
        let cell = self.tableView.cellForRow(at: IndexPath(row: 1, section: 1))
        // 지정된 부분으로 셀 반환!
        cell?.detailTextLabel?.text = date
    }

}
// MARK: - PriceTableViewCellDelegate
extension PostingTableViewController: PriceTableViewCellDelegate {
    func pass(price: String?) {
        print("\(price)")
        self.amount = price
    }
}
// MARK: - ContentTableViewCellDelegate
extension PostingTableViewController: ContentTableViewCellDelegate {
    func pass(contentTitle: String?) {
        self.contents = contentTitle
    }
}
