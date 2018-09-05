//
//  ViewController.swift
//  LocalNotification
//
//  Created by SSY on 2018. 5. 14..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var msgTF: UITextField!
    // MARK: IBAction
    @IBAction func saveButton(_ sender: Any) {
        if #available(iOS 10.0, *){
            // UserNotification 프레임 워크 사용할 로컬 알림
            
            // 1. 알림 동의 여부 확인
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized{
                    // 추가
                    DispatchQueue.main.async {
                        // 2. 알림 콘텐츠 정의
                        let nContent = UNMutableNotificationContent()
                        guard let msg = self.msgTF.text else{
                            print("입력안함")
                            return
                        }
                        nContent.body = msg
                        nContent.title = "미리 알림"
                        nContent.sound = UNNotificationSound.default()
                        // 3. 발송 시각을 '지금으로부터 **초 형식'으로 변환
                        let time = self.datePicker.date.timeIntervalSinceNow
                        // 4. 발송 조건 정의
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time,
                                                                        repeats: false)
                        // 5. 발송 요청 인스턴스 정의
                        let request = UNNotificationRequest(identifier: "alarm",
                                                            content: nContent,
                                                            trigger: trigger)
                        // 6. 노티피 케이션 센터에 추가
                        UNUserNotificationCenter.current().add(request,
                                                               withCompletionHandler: { (_) in
                            DispatchQueue.main.async {
                                // 발송 완료 안내 메시지 창
                                // 9 : GMT를 우리나라 시간에 맞춤 60: 분 60: 초
                                let date = self.datePicker.date.addingTimeInterval(9*60*60)
                                let message = "알림이 등록외었습니다. 등록된 알림은 \(date)에 발송됨"
                                let alert = UIAlertController(title: "알림등록",
                                                              message: message,
                                                              preferredStyle: .alert)
                                let ok = UIAlertAction(title: "확인", style: .default)
                                alert.addAction(ok)
                                
                                self.present(alert, animated: false)
                            }
                        })
                    }
                    
                }else{
                    let alert = UIAlertController(title: "알림등록",
                                                  message: "알림이 허용되지 않음",
                                                  preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .default)
                    alert.addAction(ok)
                    
                    self.present(alert, animated: false)
                    return
                }
            }
        }else{
            // LocalNotification 객체 사용한 로컬 알림
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

