//
//  CRUDNotificationModel.swift
//  Remind
//
//  Created by t&a on 2023/03/07.
//

import UIKit
import RealmSwift

class RealmDataBaseModel {
    //MARK: -  通知管理用RealmDBのCRUD処理モデル

    private let realm = try! Realm()

    // MARK: - Create
    public func createRecord(notice:Notification){
        try! realm.write {
            realm.add(notice)
        }
    }
    
    // MARK: - Read
    public func readIdRecord(id:UUID) -> Notification{
        return realm.objects(Notification.self).where({$0.id == id}).first!
    }
    
    // MARK: - Update
    public func updateRecord(noticeRecord:Notification,body:String,date:Date){
        try! realm.write {
            noticeRecord.body = body
            noticeRecord.date = date
        }
    }
    
    // MARK: - Delete
    public func deleteAllOldRecord(){
        try! realm.write{
            let result = realm.objects(Notification.self).where({$0.date < Date()})
            realm.delete(result)
        }
    }
}
