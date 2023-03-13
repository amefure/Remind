//
//  EntryNotificationView.swift
//  Remind
//
//  Created by t&a on 2022/10/04.
//

import SwiftUI
import RealmSwift

struct EntryNotificationView: View {
    // MARK: - 通知登録画面 & 既存通知更新画面
    
//    // Remind予定のデータのみ
//    @ObservedResults(Notification.self,
//                     where: {$0.date >= Date()},
//                     sortDescriptor:SortDescriptor(keyPath: "date",
//                                                   ascending: true)) var notification
    
    // MARK: - receive data
    public var notice:Notification? = nil
    
    // MARK: - Input
    @State var date:Date = Date() // DateTimeControlContainerView > DatePickerView.swift
    @State var text:String = ""   // DateTimeControlContainerView > DateTImeView.swift
    
    // MARK: - View
    @State var isDateDisplay:Bool = false // DateTimeControlContainerView > DatePickerView.swift
    @State var isTimeDisplay:Bool = false // DateTimeControlContainerView > DateTImeView.swift
    
    @FocusState var isFocus:Bool
    
    @Environment(\.dismiss) var dismiss
    
    private func hasNoticeResetDataOrDismiss(){
        
        if notice == nil {
            // データが存在しないならリセット
            date = Date()
            text = ""
            isTimeDisplay = false
            isDateDisplay = false
        }else{
            // データが存在するなら画面を戻す
            dismiss()
        }
    }
    
    private func hasNoticeSetData(){
        // データが存在する場合のみ初期値をセット
        if notice != nil {
            date = notice!.date
            text = notice!.body
        }
    }

    
    var body: some View {
        VStack{
            
            ScrollView{
                
                //MARK: - DateTimePicker
                DateTimeControlContainerView(date: $date,
                                      isDateDisplay: $isDateDisplay,
                                      isTimeDisplay: $isTimeDisplay)
                .onChange(of: [isDateDisplay,isTimeDisplay]) { _ in
                    isFocus = false
                }
                
                //MARK: - TextField
                NotificationTextFieldView(text: $text)
                    .focused($isFocus)
                    .onChange(of: isFocus) { value in
                        if value == true {
                            isDateDisplay = false
                            isTimeDisplay = false
                        }
                    }
                
                // MARK: - EntryButton
                EntryButtonView(notice: notice,date: $date,text: $text,parentFunction: hasNoticeResetDataOrDismiss)
                

            }.padding(.top)
            
            Spacer()
            
            AdMobBannerView().frame(height:50)
            
        }.onAppear{
            hasNoticeSetData()
        }.ignoresSafeArea(.keyboard) // キーボードで広告が上下しないようにする
    }
}


