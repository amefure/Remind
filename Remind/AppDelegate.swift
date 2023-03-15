//
//  AppDelegate.swift
//  Remind
//
//  Created by t&a on 2022/10/05.
//

import Foundation
import UIKit
import GoogleMobileAds

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // AdMob
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        // 通知申請
        NotificationViewModel().requestUserAuthorization { error in
            if error == nil {
                // フォアグラウンド通知対応
                UNUserNotificationCenter.current().delegate = self
            }
        }
        return true
    }
}

extension AppDelegate :UNUserNotificationCenterDelegate{
    // フォアグラウンド通知対応
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([[.banner, .list, .sound]])
        }
}
