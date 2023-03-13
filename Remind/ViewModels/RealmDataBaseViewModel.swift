//
//  CRUDRecordViewModel.swift
//  Remind
//
//  Created by t&a on 2023/03/08.
//

import UIKit
import RealmSwift


class RealmDataBaseViewModel {
    // MARK: -  通知管理用RealmDBのCRUD処理ViewModel
    
    // MARK: - Models
    private let model = RealmDataBaseModel()
    
    // MARK: - Create
    public func createRecord(body:String,date:Date) -> Notification{
        let notice = Notification()
        notice.body = body
        notice.date = date
        model.createRecord(notice: notice)
        return notice
    }
    
    // MARK: - Update
    public func updateRecord(id:UUID,body:String,date:Date) -> Notification{
        let noticeRecord = model.readIdRecord(id: id)
        model.updateRecord(noticeRecord: noticeRecord, body: body, date: date)
        let newNoticeRecord = model.readIdRecord(id: noticeRecord.id)
        return newNoticeRecord
    }
    
    // MARK: - Delete
    public func deleteAllOldRecord(){
        model.deleteAllOldRecord()
    }
}
