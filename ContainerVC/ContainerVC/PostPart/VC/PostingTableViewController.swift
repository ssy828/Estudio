//
//  PostingTableViewController.swift
//  ContainerVC
//
//  Created by SSY on 2018. 8. 20..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit
//MARK: UITableViewController
class PostingTableViewController: UITableViewController {
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
        return 3
    }
    // MARK: numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 3
        default:
            return 1
        }
        
    }
    // MARK: cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            let contentsCell = tableView.dequeueReusableCell(withIdentifier: "ContentsCell", for: indexPath) as! ContentTableViewCell
//            self.contents = contentsCell.contentsTextField.text
            contentsCell.delegate = self
            return contentsCell
        case (0,1):
            let priceCell = tableView.dequeueReusableCell(withIdentifier: "PriceCell", for: indexPath) as! PriceTableViewCell
//            self.amount = priceCell.priceTextField.text
//            priceCell.didAddHandler = { [weak self] (text) in
//                guard let `self` = self else {return}
//                self.amount = text
//            }
            priceCell.delegate = self
            return priceCell
        case (1,0):
            let colorPickerCell = tableView.dequeueReusableCell(withIdentifier: "ColorPickerCell", for: indexPath) as! ColorPickerTableViewCell
            colorPickerCell.didAddHandler = { [weak self] (color,text) in
                guard let `self` = self else {return}
                self.color = color
                self.colorText = text
            }
            return colorPickerCell
        case (1,1):
            if let dateCell = tableView.dequeueReusableCell(withIdentifier: "DateCell") {
                return dateCell
            }
            return UITableViewCell()
        case (1,2):
            let datePickerCell = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell", for: indexPath) as! DateTableViewCell
            datePickerCell.delegate = self
            return datePickerCell
        case (2,0):
            let textviewCell = tableView.dequeueReusableCell(withIdentifier: "TextViewCell", for: indexPath) as! TextViewTableViewCell
            return textviewCell
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
