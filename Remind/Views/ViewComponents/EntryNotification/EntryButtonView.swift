//
//  EntryButtonView.swift
//  Remind
//
//  Created by t&a on 2023/03/13.
//

import SwiftUI
import RealmSwift

struct EntryButtonView: View {
    
    // MARK: - ViewModels
    private let notificationViewModel = NotificationViewModel()
    private let realmDataBaseViewModel = RealmDataBaseViewModel()
    private let displayDateViewModel = DisplayDateViewModel()
    
    // MARK: - receive data
    public var notice:Notification? = nil
    
    // MARK: - Input
    @Binding var date:Date
    @Binding var text:String
    
    // MARK: - View
    @State var isAlert:Bool = false
    
    
    // MARK: - method
    var parentFunction:() -> Void
    
    var body: some View {
        Button(action: {
            
            if !text.isEmpty {
                var currntItem:Notification
                if notice != nil {
                    currntItem = realmDataBaseViewModel.updateRecord(id:notice!.id,body: text, date: date)
                }else{
                    currntItem = realmDataBaseViewModel.createRecord(body: text, date: date)
                }
                
                let dateStr = displayDateViewModel.getNoticeFormatString(currntItem.date)
                notificationViewModel.createNotification(id: currntItem.id, body: currntItem.body, dateStr:dateStr)
                isAlert = true
            }
            
            
        }, label: {
            Text(notice != nil ? "更新" : "登録")
                .fontWeight(.bold)
                .padding(10)
                .frame(width: DeviceSizeModel.deviceWidth - 30)
                .background(Color("AccentColor"))
                .foregroundColor(.white)
                .cornerRadius(5)
                .padding()
                .shadow(color: .gray,radius: 3, x: 2, y: 2)
        }).alert(notice != nil ? "Remindを更新しました。" : "\(displayDateViewModel.getAllDisplayFormatStringNoReturn(date))にRemindを登録しました。",
                 isPresented: $isAlert,
                 actions: {
            Button("OK") {
                // func hasNoticeResetDataOrDismiss()
                parentFunction()
            }
        })
    }
}

