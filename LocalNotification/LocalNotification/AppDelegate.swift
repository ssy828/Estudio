//
//  AppDelegate.swift
//  LocalNotification
//
//  Created by SSY on 2018. 5. 14..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    //처음 실행 될때 호출되는 메소드
    //시작화면이 스크린에 표시되고 있는 동안 호출
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 10.0, *) {
            // 경고창, 배지, 사운드를 사용하는 알림 환경 정보 생성
            // 사용자 동의 여부 창을 실행
            let notiCenter = UNUserNotificationCenter.current()
            notiCenter.requestAuthorization(options: [.alert,.badge,.sound]) { (didAllow, error) in
                notiCenter.delegate = self // 알림과 관련된 일이 발생하면 앱 델리게이트(나)에게 알려줘!
            }
        }else{
            // 경고창, 배지, 사운드 알림 환경 정보 생성
            // 이를 애플리케이션에 저장
            let setting = UIUserNotificationSettings(types:[.alert,.badge,.sound], categories: nil)
            application.registerUserNotificationSettings(setting)
        }
        
        return true
    }
    
    // 앱이 비활성화인 경우 실행 되는 메소드
    func applicationWillResignActive(_ application: UIApplication) {
        if #available(iOS 10.0, *){ // UserNotification 프레임 워크를 이용한 로컬 알림(ios 10 이상) -> ios 10 이상 버전은 if 조건절 실행
            // 알림 동의 여부 확인
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized{
                    // 알림 콘텐츠 인스턴스
                    let nContent = UNMutableNotificationContent()
                    nContent.badge = 1
                    nContent.title = "로컬 알림 메시지"
                    nContent.subtitle = "다시 열어주세요~"
                    nContent.body = "왜 나갔어요? 다시 들어와 주세요~"
                    nContent.sound = UNNotificationSound.default()
                    nContent.userInfo = ["name":"가나다"]
                    
                    // 알림 발송 조건 인스턴스
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                    
                    // 알림 요청 인스턴스
                    // 식별 아이디: 여러 개의 알림 요청 중에서 원하는 것을 식별하는 용도
                    let request = UNNotificationRequest(identifier: "일어나", content: nContent, trigger: trigger)
                    
                    // 노티피케이션 센터에 추가
                    UNUserNotificationCenter.current().add(request)
                } else{
                    print("사용자가 동의 하지 않음")
                }
            }
        }else{ // ios 9이하 UILocalNotification 이용
            
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

// MARK: -UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    @available(iOS 10.0, *) // ios 10 버전부터만 가능한 메소드
    // 앱 실행 중 메시지 알림 등 배너로 표시 가능한 메소드
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping(UNNotificationPresentationOptions) -> Void) {
        if notification.request.identifier == "일어나" { // 식별 아이디: 클릭한 알림 메시지 구별가능
            let userInfo = notification.request.content.userInfo
            print(userInfo["name"]!)
        }
        // 알림 배너 띄워주기
        completionHandler([.alert,.badge,.sound]) // 호출하지 않으면 배너에 표시 안됨
    }
    @available(iOS 10.0, *)
    // 실제 사용자가 배너 클릭시 실행되는 메소드
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "일어나"{
            let userInfo = response.notification.request.content.userInfo
            print(userInfo["name"]!)
        }
    }
}

