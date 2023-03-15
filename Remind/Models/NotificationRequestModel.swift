//
//  NotificationRequestManager.swift
//  Remind
//
//  Created by t&a on 2022/10/04.
//

import UIKit



class NotificationRequestModel {
    //MARK: -  通知リクエスト管理モデル
    // 端末に対して通知(※)を登録、更新、削除する処理を持っているモデル
    // 登録：通知リクエスト(UNNotificationRequest)を受け取り登録
    // 削除：登録済み通知のIDを受け取り削除
    
    //MARK: - 通知タイトル
    public let title:String = "Remind"
    
    //MARK: - 通知センター
    private let currentCenter:UNUserNotificationCenter = UNUserNotificationCenter.current()
    
    //MARK: - 通知リクエストを登録(または上書き)
    public func entryNotificationRequest(_ request:UNNotificationRequest,
                                         completion: @escaping (NotificationError?) -> Void) {
        self.currentCenter.add(request) { error in
            if error == nil{
//                print("登録成功")
                completion(nil)
            }else{
//                print("登録失敗")
                completion(NotificationError.notificationRequestFailed)
            }
        }
    }
    //MARK: - 通知リクエストを削除
    public func deleteNotificationRequest(id:UUID){
        self.currentCenter.removePendingNotificationRequests(withIdentifiers: [id.uuidString])
        
    }
    //MARK: - 通知申請
    public func requestUserAuthorization(completion: @escaping (NotificationError?) -> Void) {
        
        self.currentCenter.requestAuthorization(options: [.alert,.badge,.sound]) { granted, error in
            if granted {
                // print("承認されました")
                completion(nil)
            }else{
                // print("拒否されました")
                completion(NotificationError.authorizationDenied)
            }
        }
    }
}

#if DEBUG
extension NotificationRequestModel {
    //MARK: - 通知リクエストを表示
    public func printNotificationRequest(){
        self.currentCenter.getPendingNotificationRequests { array in
            print(array)
        }
    }
}
#endif
