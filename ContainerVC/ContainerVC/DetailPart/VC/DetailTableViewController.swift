//
//  DetailTableViewController.swift
//  ContainerVC
//
//  Created by SSY on 2018. 5. 23..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit
// MARK: - UITableViewController
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
    // toggleDatePicker
    private func toggleDatePicker() {
        self.datePickerIsHidden = !datePickerIsHidden // 현재 데이트 피커의 상태를 데이트피커(불타입) 프로퍼티에 넣어줌
        self.tableView.beginUpdates() // Begins a series of method calls that insert, delete, or select rows and sections of the table view.
        self.tableView.endUpdates() // Concludes a series of method calls that insert, delete, select, or reload rows and sections of the table view.
    }
 
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentTF.becomeFirstResponder()
        self.contentTF.delegate = self
        self.allowanceTF.delegate = self
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
// MARK: - UITextFieldDelegate
extension DetailTableViewController: UITextFieldDelegate {
    // MARK: shouldChangeCharactersIn
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case contentTF:
            return true
        default:
            // Uses the number format corresponding to your Locale
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.locale = Locale.current // 사용자의 지역 설정
            numberFormatter.maximumFractionDigits = 0 // 소수점 이하 최대 자릿수 -> 소수점 없을 예정이므로 0으로 설정
            
            if let inputString = allowanceTF.text?.replacingOccurrences(of: numberFormatter.groupingSeparator, with: ""){ // ,(쉼표)를 제거
                var combinedString = inputString + string // 원래 있던 문자열과 새로 들어온 문자열 합침
                if numberFormatter.number(from: string) != nil { // 새로 입력된 값이 숫자만 이루어진 것이 아닌 경우
                    // 입력된 값을 NSNumber형태로 바꾼 후 다시 String 형태로 변경!
                    if let completedNumberString = numberFormatter.number(from: combinedString), let completedString = numberFormatter.string(from: completedNumberString) {
                        allowanceTF.text = completedString
                        return false
                    }
                }else {
                    if string == "" { // 백스페이스로 문자열이 없거나 숫자가 아닌 문자열이 들어왔을 경우
                        let lastInedex = combinedString.index(combinedString.endIndex, offsetBy: -1) // 문자를 하나씩 지우면 쉼표를 그만큼 앞으로 이동시켜야하므로
                        combinedString = String(combinedString[..<lastInedex])
                        if let completedNumberString = numberFormatter.number(from: combinedString), let completedString = numberFormatter.string(from: completedNumberString) {
                            allowanceTF.text = completedString
                            return false
                        }
                    }
                }
            }
            return true
        }
    }
    // 텍스트 필드의 리턴 키가 눌러졌을 때 호출
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if contentTF.isFirstResponder{ // 컨첸츠 텍스트 필드이면 지출금액필드로 입력 넘어가게 함
            allowanceTF.becomeFirstResponder() // 바로 값을 입력받게 해줌
        }else if allowanceTF.isFirstResponder {
            allowanceTF.resignFirstResponder() // 화면에서 키보드 사라지게 함
        }
        return true
    }
}
