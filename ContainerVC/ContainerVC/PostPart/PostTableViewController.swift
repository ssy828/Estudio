//
//  PostTableViewController.swift
//  ContainerVC
//
//  Created by SSY on 2018. 7. 9..
//  Copyright © 2018년 LittleMe. All rights reserved.

import UIKit
// MARK: - UITableViewController
class PostTableViewController: UITableViewController {
    
    // MARK: properties
    static var identifier: String {
        return String(describing: self)
    }
    private var datePickerIsHidden: Bool = false
//    public var didAddHandler: ((Section,DetailData) -> Void)?// 클로저를 통해서 데이터 교환
    public var didAddHandler: ((CategoryTitle, DetailData) -> Void)?
    public var itemToEdit: Section?
    // MARK: IBOutlet
    @IBOutlet weak var contentTF: UITextField! // 내용
    @IBOutlet weak var allowanceTF: UITextField! // 금액
    @IBOutlet weak var categoryLB: UILabel! // 분류 타이틀
    @IBOutlet weak var categoryColorView: UIView! // 분류 색상
    @IBOutlet weak var dateLB: UILabel! // 날짜
    @IBOutlet weak var datePicker: UIDatePicker! // 날짜 선택
    @IBOutlet weak var memoTextView: UITextView! // 메모
    
    // MARK: IBAction
    @IBAction func didChangeDate() {
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "yyyy년MM월dd일" // 원하는 날짜 형식
        dateLB.text = dateFomatter.string(from: datePicker.date)
    }
    // done 버튼 눌렀을 경우
    @IBAction func didClickDoneButton(_ sender: UIBarButtonItem) {
        guard let categoryTitle = self.categoryLB.text else { return }
        guard let content = self.contentTF.text else { return }
        guard let amount = self.allowanceTF.text else { return }
//        guard let date = self.dateLB.text else { return }
        guard let categoryColor = self.categoryColorView.backgroundColor else { return }
        if let sectionTitle = CategoryTitle(rawValue: categoryTitle){
           let items = DetailData(content: content, amount: amount, color:categoryColor, title: sectionTitle)
//            let data = Section(title: sectionTitle, items: [items], isCollapsed: true)
            self.didAddHandler?(sectionTitle,items)
        }
//        self.test(title: categoryTitle, color: categoryColor, isCollapsed: true, items: [detailData])
        
       self.dismiss(animated: false, completion: nil)
    }
    // 함수 기능 분산 시켜서 사용하려고 테스트 하는 중!!!
//    func test(title: String, color: UIColor, isCollapsed: Bool = true, items: [DetailData]) {
//
//        guard let title = CategoryTitle(rawValue: title) else { return }
//        if title != itemToEdit?.title {
//            let data = Category(title: title, color: color, isCollapsed: isCollapsed, items: items)
//            self.didAddHandler?(data,)
//        }else {
//            let data = Category(items: items)
//            self.didAddHandler?(data)
//        }
//
//
//    }

    @IBAction func didClickUndoButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }
    
    // MARK: Methods
    // MARK: toggleDatePicker
    private func toggleDatePicker() {
        self.datePickerIsHidden = !datePickerIsHidden // 현재 데이트 피커의 상태를 데이트피커(불타입) 프로퍼티에 넣어줌
        self.tableView.beginUpdates() // Begins a series of method calls that insert, delete, or select rows and sections of the table view.
        self.tableView.endUpdates() // Concludes a series of method calls that insert, delete, select, or reload rows and sections of the table view.
    }
    // MARK: addDoneButtonOnNumberPad
    private func addDoneButtonOnNumberPad() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        // toolBar.items의 배열에 아이템이 들어가는 순서가 왼쪽부터이므로 오른쪽에 붙여주기 위한 코드
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self, action: #selector(didPressDoneButton))
        toolBar.items = [flexibleSpace, doneButton]
        allowanceTF.inputAccessoryView = toolBar
    }
    @objc private func didPressDoneButton() {
        self.allowanceTF.resignFirstResponder()
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentTF.delegate = self
        self.allowanceTF.delegate = self
        self.memoTextView.delegate = self
        self.addDoneButtonOnNumberPad()
        self.didChangeDate() // 이 부분을 넣어야 바로바로 날짜 레이블이 갱신됨
        self.toggleDatePicker() // 데이트피커를 눌렀을때마다 실행되게끔
        
//        if let item = self.itemToEdit{
//            guard let title = item.title else { return }
//            guard let color = item.color else { return }
//            self.test(title: title.rawValue, color: color, isCollpased: true, items: item.items)
//        }
        
        // 수정할 경우
        if let items = self.itemToEdit {
            title = "수정" // 내비게이션 바 타이틀 수정
            print("\(items)")
            for data in items.items {
                print("!!!!!!!\(data)")
                self.contentTF.text = data.content
                self.allowanceTF.text = data.amount
                self.categoryColorView.backgroundColor = data.color
                self.categoryLB.text = data.title.rawValue
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // 필요함: 이유는...
        self.contentTF.becomeFirstResponder() // 내용 텍스트 필드 최초응답자로 설정

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
    
    
    
    //         // MARK: - Navigation
    //         // In a storyboard-based application, you will often want to do a little preparation before navigation
    //         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //         // Get the new view controller using segue.destinationViewController.
    //         // Pass the selected object to the new view controller.
    //            if let destination = segue.destination as? CategoryViewController {
    //                destination.didAddHandler = { buttonColor in
    //                    self.itemToEdit?.color = buttonColor
    //                }
    //            }
    //         }
    
    // MARK: didSelectRowAt
    // 이 메소드만으로는 datePicker 사라지지 않음 -> heightForRowAt에서 각각의 테이블 행의 높이를 제공해야한다
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (1,1):
            self.toggleDatePicker()
        case (1,0):
            let categoryVC = storyboard?.instantiateViewController(withIdentifier: CategoryViewController.identifier) as! CategoryViewController
            categoryVC.didAddHandler = { [weak self] (color,title) in
                guard let `self` = self else { return }
                self.categoryColorView.backgroundColor = color
                self.categoryLB.text = title
            }
            self.navigationController?.pushViewController(categoryVC, animated: false)
            self.tableView.reloadData() // 데이터 수정에 대한 반응
        default:
            break
        }
    }
    // MARK: heightForRowAt
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        if datePickerIsHidden && indexPath.section == 1 && indexPath.row == 2 {
            return 0 // 아예 이 행의 높이를 0으로 해야 눈에서 사라지는 효과
            // 왜 사라질때 표시가 될까??
        }else{
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
}
// MARK: - UITextFieldDelegate
extension PostTableViewController: UITextFieldDelegate {
    // MARK: shouldChangeCharactersIn
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        switch textField {
        case contentTF:
            return true
        default:
            // Uses the number format corresponding to your Locale
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.locale = Locale.current // 사용자의 지역 설정
            numberFormatter.maximumFractionDigits = 0 // 소수점 이하 최대 자릿수 -> 소수점 없을 예정이므로 0으로 설정
            if let inputString = allowanceTF.text?.replacingOccurrences(of: numberFormatter.groupingSeparator,                                                                with: ""){ // ,(쉼표)를 제거
                var combinedString = inputString + string // 원래 있던 문자열과 새로 들어온 문자열 합침
                if numberFormatter.number(from: string) != nil { // 새로 입력된 값이 숫자만 이루어진 것이 아닌 경우
                    // 입력된 값을 NSNumber형태로 바꾼 후 다시 String 형태로 변경!
                    if let completedNumberString = numberFormatter.number(from: combinedString),
                        let completedString = numberFormatter.string(from: completedNumberString) {
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
    // MARK: textFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 컨첸츠 텍스트 필드가 최초 응답자이면 지출금액 필드로 입력으로 넘김
        if contentTF.isFirstResponder{
            allowanceTF.becomeFirstResponder() // 바로 값을 입력받게 해줌
        }
        return true
    }
}
// MARK: - UITextViewDelegate
extension PostTableViewController: UITextViewDelegate {
    // textview에는 textFieldShouldReturn 메소드가 없으므로
    // shouldChangeTextIn 메소드에서 실행
    // 엔터를 누르면 줄바꿈이 되는데 엔터(done)을 누를 경우 키보드 사라지게 하기
    // MARK: shouldChangeTextIn
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        if text == "\n"{
            memoTextView.resignFirstResponder() // 최초 응답자 해제
            return false
        }
        return true
    }
}

