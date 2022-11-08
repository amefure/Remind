//
//  EditNotificationView.swift
//  Remind
//
//  Created by t&a on 2022/11/08.
//

import SwiftUI
import RealmSwift

struct EditNotificationView: View {
    // MARK: - Models
    let manager = NotificationRequestManager()
    
    // MARK: - receive data
    var notice:Notification
    
    // MARK: - Input
    @State var date:Date = Date()
    @State var text:String = ""
    
    // MARK: - View
    @State var isInput:Bool = true
    @State var isAlert:Bool = false
    
    // MARK: - method
    func setData(){
        date = notice.date
        text = notice.body
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
                                       
                    let realm = try! Realm()
                    let noticeRecord = realm.objects(Notification.self).where({$0.id == notice.id}).first!
                    
                    try! realm.write {
                        // 更新処理
                        noticeRecord.body = text
                        noticeRecord.date = date
                        
                        let df = DateFormatter()
                        df.dateFormat = "yyyy-MM-dd-H-m"
                        let dateStr = df.string(from: noticeRecord.date)
                        // 通知を同じIDで上書きする
                        manager.sendsendNotificationRequest(id: noticeRecord.id, str: noticeRecord.body, dateStr:dateStr)
                    }
                    isAlert = true
                    isInput = true
                    
                }else{
                    isInput = false
                }
            }, label: {
                Text("更新")
                    .fontWeight(.bold)
                    .padding()
                    .background(Color("AccentColor"))
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }).alert("Remindを更新しました。", isPresented: $isAlert, actions: {})
            
            Spacer()
            
            AdMobBannerView().frame(height:30).padding(.bottom)
        }.onAppear{
            setData()
        }
    }
}

