//
//  DetailTableViewController.swift
//  ContainerVC
//
//  Created by SSY on 2018. 5. 23..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit
// MARK: - UITableViewController
class ModifiedPostTableViewController: UITableViewController {
    
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
    // MARK: toggleDatePicker
    private func toggleDatePicker() {
        self.datePickerIsHidden = !datePickerIsHidden
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    // MAKR: addDoneButtonOnNumberPad
    private func addDoneButtonOnNumberPad() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didPressDoneButton))
        toolBar.items = [flexibleSpace, doneButton]
        allowanceTF.inputAccessoryView = toolBar
    }
    @objc private func didPressDoneButton() {
        self.allowanceTF.resignFirstResponder()
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentTF.becomeFirstResponder()
        self.contentTF.delegate = self
        self.allowanceTF.delegate = self
        self.memoTextView.delegate = self
        self.addDoneButtonOnNumberPad()
        self.didChangeDate()
        self.toggleDatePicker()
        
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
    // MARK: didSelectRowAt
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
    // MARK: heightForRowAt
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if datePickerIsHidden && indexPath.section == 1 && indexPath.row == 2 {
            return 0
        }else{
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
}
// MARK: - UITextFieldDelegate
extension ModifiedPostTableViewController: UITextFieldDelegate {
    // MARK: shouldChangeCharactersIn
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case contentTF:
            return true
        default:
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.locale = Locale.current
            numberFormatter.maximumFractionDigits = 0
            if let inputString = allowanceTF.text?.replacingOccurrences(of: numberFormatter.groupingSeparator, with: ""){
                var combinedString = inputString + string
                if numberFormatter.number(from: string) != nil {
                    if let completedNumberString = numberFormatter.number(from: combinedString), let completedString = numberFormatter.string(from: completedNumberString) {
                        allowanceTF.text = completedString
                        return false
                    }
                }else {
                    if string == "" {
                        let lastInedex = combinedString.index(combinedString.endIndex, offsetBy: -1)
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
    // MARK: textFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if contentTF.isFirstResponder{
            allowanceTF.becomeFirstResponder()
        }
        return true
    }
}
// MARK: - UITextViewDelegate
extension ModifiedPostTableViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            memoTextView.resignFirstResponder()
            return false
        }
        return true
    }
}
