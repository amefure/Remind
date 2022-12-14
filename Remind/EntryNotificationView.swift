//
//  EntryNotificationView.swift
//  Remind
//
//  Created by t&a on 2022/10/04.
//

import SwiftUI
import RealmSwift

struct EntryNotificationView: View {
    
    // MARK: - Models
    let manager = NotificationRequestManager()
    @ObservedResults(Notification.self) var notification
    
    // MARK: - Input
    @State var date:Date = Date()
    @State var text:String = ""
    
    // MARK: - View
    @State var isInput:Bool = true
    @State var isAlert:Bool = false
    
    // MARK: - method
    func resetData(){
        date = Date()
        text = ""
    }
    
    // MARK: - 選択可能な日付を定義
    let dateRange: ClosedRange<Date> = {
            let calendar = Calendar.current
            let start = calendar.date(byAdding: .day, value: 0, to: Date())!   // 今日から
            let end = calendar.date(byAdding: .year, value: 1000, to: Date())! // 1000年後
            return start...end
        }()
    
    var body: some View {
        VStack{
            
            Spacer()
            
            // MARK: - DatePicker
            DatePicker(selection: $date, in: dateRange, displayedComponents: [.date,.hourAndMinute]) {
                Text("日付")
            }
            .environment(\.locale, Locale(identifier: "ja_JP"))
            .environment(\.calendar, Calendar(identifier: .japanese))
            .environment(\.timeZone, TimeZone(identifier: "Asia/Tokyo")!)
            .datePickerStyle(.graphical)
            // MARK: - DatePicker
            
            // MARK: - TextField
            TextField("通知内容", text: $text)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(isInput ? Color("AccentColor") :.red ,lineWidth: 3)
                )
                .textFieldStyle(.roundedBorder)
                .padding([.bottom,.trailing,.leading])
            // MARK: - TextField
            
            // MARK: - EntryButton
            Button(action: {
                
                if text != "" {
                    
                    let notice = Notification()
                    notice.body = text
                    notice.date = date
                    
                    
                    let realm = try! Realm()
                    
                    try! realm.write {

                        // 追加処理
                        realm.add(notice)
                        
                        // 通知セット
                        let currntItem = realm.objects(Notification.self).last!
                        let df = DateFormatter()
                        df.dateFormat = "yyyy-MM-dd-H-m"
                        let dateStr = df.string(from: currntItem.date)
                        manager.sendsendNotificationRequest(id: currntItem.id, str: currntItem.body, dateStr:dateStr)
                    }
                    
                    isAlert = true
                    isInput = true
                    resetData()
                    
                }else{
                    
                    isInput = false
                }
                
                
            }, label: {
                Text("登録")
                    .fontWeight(.bold)
                    .padding()
                    .background(Color("AccentColor"))
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }).alert("Remindを登録しました。", isPresented: $isAlert, actions: {})
            
            Spacer()
            
            AdMobBannerView().frame(height:30).padding(.bottom)
        }
    }
}


