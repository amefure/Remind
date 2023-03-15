//
//  NotificationViewModel.swift
//  Remind
//
//  Created by t&a on 2023/03/07.
//

import UIKit

class NotificationViewModel {
    // MARK: -  通知リクエスト用ViewModel
    
    // MARK: - Model
    private let model = NotificationRequestModel()
    private let errModel = ErrorModel.shared
    
    // 通知ID
    public var id:UUID? = nil
    
    // MARK: - Create
    public func createNotification(id:UUID,body:String,dateStr:String){
        /// 通知リクエストを構築して登録処理呼び出し
        let content = self.createContent(id: id, body: body)
        let dateComponents = self.createDateComponents(dateStr: dateStr)
        let request = self.createNotificationRequest(dateComponents, content)
        self.sendNotification(request: request)
    }
    
    // 通知内容を構築 - 1
    private func createContent(id:UUID,body:String) -> UNMutableNotificationContent{
        self.id = id
        let content = UNMutableNotificationContent()
        content.title = model.title
        content.body = body
        return content
        
    }
    
    // 通知日付を構築 - 2
    private func createDateComponents(dateStr:String) -> DateComponents{
        // "yyyy-MM-dd-H-m"形式で取得した文字列を配列に変換
        let array = dateStr.split(separator: "-")
        let dateComponents = DateComponents(year: Int(array[0]),
                                            month: Int(array[1]),
                                            day: Int(array[2]),
                                            hour: Int(array[3]),
                                            minute: Int(array[4]),
                                            second: 0)
        return dateComponents
    }
    
    // 通知リクエストを構築 - 3
    private func createNotificationRequest(_ dateComponents:DateComponents,_ content:UNMutableNotificationContent) -> UNNotificationRequest{
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: self.id!.uuidString, content: content, trigger: trigger)
        return request
    }
    
    // 通知リクエストをセンターに送信して登録 - 4
    private func sendNotification(request:UNNotificationRequest){
        model.entryNotificationRequest(request) { error in
            if error != nil{
                self.errModel.setCurrentError(error!)
            }
        }
    }
    // MARK: - Create
    
    // MARK: - Delete
    public func deleteNotification(id:UUID){
        model.deleteNotificationRequest(id: id)
    }
    
    
    //MARK: - 通知申請
    public func requestUserAuthorization(completion: @escaping (NotificationError?) -> Void) {
        model.requestUserAuthorization { error in
            if error != nil{
                self.errModel.setCurrentError(error!)
            }
            completion(error)
        }
    }
}


#if DEBUG
extension NotificationViewModel{
    // MARK: - Read
    public func printNotification(){
        model.printNotificationRequest()
    }
}
#endif
