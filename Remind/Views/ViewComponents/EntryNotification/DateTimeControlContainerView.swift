//
//  DateTimeContainerView.swift
//  Remind
//
//  Created by t&a on 2023/03/13.
//

import SwiftUI

struct DateTimeControlContainerView: View {
    // MARK: - 通知日時表示コントロールコンテナー
    
    // MARK: - ViewModels
    private let displayDateViewModel = DisplayDateViewModel()
    
    // MARK: - Main Property
    @Binding var date:Date
    
    // MARK: - Display
    @Binding var isDateDisplay:Bool // DatePickerView.swift
    @Binding var isTimeDisplay:Bool // DateTimeView.swift
    
    // MARK: - 選択可能な日付を定義
    static let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let start = calendar.date(byAdding: .day, value: 0, to: Date())!   // 今日から
        let end = calendar.date(byAdding: .year, value: 1000, to: Date())! // 1000年後
        return start...end
    }()
    
    var body: some View {
        Group{
            
            HStack{
                /// 日付表示ボタン
                Button {
                    isDateDisplay.toggle()
                    if isTimeDisplay {
                        isTimeDisplay = false
                    }
                } label: {
                    HStack{
                        Image(systemName:"calendar")
                        Text(displayDateViewModel.getDateDisplayFormatString(date))
                    }
                }.mainButton()
                
                Spacer()
                
                /// 時間表示ボタン
                Button {
                    isTimeDisplay.toggle()
                    if isDateDisplay {
                        isDateDisplay = false
                    }
                } label: {
                    HStack{
                        Image(systemName:"clock")
                        Text(displayDateViewModel.getTimeDisplayFormatString(date))
                    }
                }.mainButton()
                
            }.padding(DeviceSizeModel.isSESize ? [.trailing,.leading] : .all )
            
            //MARK: - Display
            if isDateDisplay{
                DatePickerView(date: $date)
            }
            if isTimeDisplay{
                TimePickerView(time: $date)
            }
        }
    }
}

