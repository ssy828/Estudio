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
    
    // MARK: enum PostSection
     enum PostSection: Int {
        case firstSection
        case secondSection
        case thirdSection
        
        static var numberOfSection: Int { return 3 }
        
        var numberOfRowsInSection: Int {
            get {
                switch self {
                case .firstSection: return 2
                case .secondSection: return 3
                case .thirdSection: return 1
                }
            }
        }
    }
    private enum Row: Int {
        case title
        case price
        case colorPicker
        case date
        case datePicker
        case text
        case unknown
        
        init(indexPath: IndexPath) {
            var row = Row.unknown
            guard let section = PostSection(rawValue: indexPath.section) else { return }
            switch (section, indexPath.row) {
            case (.firstSection, 0):
                row = Row.title
            case (.firstSection, 1):
                row = Row.price
            case (.secondSection, 0):
                row = Row.colorPicker
            case (.secondSection, 1):
                row = Row.date
            case (.secondSection, 2):
                row = Row.datePicker
            case (.thirdSection, 0):
                row = Row.text
            default:
                break
            }
//            assert(row != Row.unknown)
//            self = row
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
        // 셀클래스를 추가해줌
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
        //        return PostSection.count.rawValue
        return PostSection.numberOfSection
    }
//     MARK: numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = PostSection(rawValue: section) else { return 0 }
        return section.numberOfRowsInSection
    }
    
    // MARK: cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        guard let section = PostSection(rawValue: indexPath.section) else {
            return tableView.dequeueReusableCell(UITableViewCell.self, for: indexPath)
        }
        switch (section, row) {
        case (.firstSection, 0):
            let cell = tableView.dequeueReusableCell(ContentTableViewCell.self, for: indexPath)
            return cell
        case (.firstSection, 1):
            let cell = tableView.dequeueReusableCell(PriceTableViewCell.self, for: indexPath)
            return cell
        case (.secondSection, 0):
            let cell = tableView.dequeueReusableCell(ColorPickerTableViewCell.self, for: indexPath)
            return cell
        case (.secondSection, 1):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateDetailCell", for: indexPath)
            return cell
        case (.secondSection, 2):
            let cell = tableView.dequeueReusableCell(DateTableViewCell.self, for: indexPath)
            return cell
        case (.thirdSection, 0):
            let cell = tableView.dequeueReusableCell(TextViewTableViewCell.self, for: indexPath)
            return cell
        default:
            return UITableViewCell()
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
        let row = indexPath.row
        guard let section = PostSection(rawValue: indexPath.section) else { return }
        switch (section, row) {
        case (.secondSection, 1):
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
