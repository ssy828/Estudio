//
//  DetailTableViewController.swift
//  ContainerVC
//
//  Created by SSY on 2018. 5. 23..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    // MARK: properties
    static var identifier: String {
        return String(describing: self)
    }
    var datePickerIsHidden: Bool = false
    
    // MARK: IBOutlet
    @IBOutlet weak var contentTF: UITextField!
    @IBOutlet weak var allowanceTF: UITextField!
    @IBOutlet weak var categoryLB: UILabel!
    @IBOutlet weak var categoryColorView: UIView!
    @IBOutlet weak var dateLB: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var memoTextView: UITextView!
    
    // MARK: IBAction
    @IBAction func didChangeDate() {
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "yyyy년MM월dd일" // 원하는 날짜 형식
        dateLB.text = dateFomatter.string(from: datePicker.date)
    }
    
    // MARK: Methods
    private func toggleDatePicker() {
        self.datePickerIsHidden = !datePickerIsHidden // 현재 데이트 피커의 상태를 데이트피커(불타입) 프로퍼티에 넣어줌
        self.tableView.beginUpdates() // Begins a series of method calls that insert, delete, or select rows and sections of the table view.
        self.tableView.endUpdates() // Concludes a series of method calls that insert, delete, select, or reload rows and sections of the table view.
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.didChangeDate() // 이 부분을 넣어야 바로바로 날짜 레이블이 갱신됨
        self.toggleDatePicker() // 데이트피커를 눌렀을때마다 실행되게끔
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //
    //    }
    
    
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
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    // didSelectRowAt
    // 이 메소드만으로는 datePicker 사라지지 않음 -> heightForRowAt에서 각각의 테이블 행의 높이를 제공해야한다
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (1,1):
            self.toggleDatePicker()
        case (1,0):
            self.performSegue(withIdentifier: "GoToCategoryVC", sender: nil)
        default:
            break
        }
    }
    // heightForRowAt
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if datePickerIsHidden && indexPath.section == 1 && indexPath.row == 2 {
            return 0 // 아예 이 행의 높이를 0으로 해야 눈에서 사라지는 효과
            // 왜 사라질때 표시가 될까??
        }else{
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
}

