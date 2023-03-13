//
//  DatePickerView.swift
//  Remind
//
//  Created by t&a on 2023/03/08.
//

import SwiftUI

struct DatePickerView: View {
    // MARK: - 通知用日付ピッカー

    @Binding var date:Date 
    
    var body: some View {
        DatePicker(selection: $date, in: DateTimeControlContainerView.dateRange, displayedComponents: [.date]) {
            Text("日付")
        }
        .environment(\.locale, Locale(identifier: "ja_JP"))
        .environment(\.calendar,DeviceSizeModel.calendar)
        .environment(\.timeZone, TimeZone(identifier: "Asia/Tokyo")!)
        .datePickerStyle(.graphical)
        .scaleEffect(x: DeviceSizeModel.isSESize ? 0.9 : 1 , y: DeviceSizeModel.isSESize ? 0.9 : 1)
        
    }
}

