//
//  TimePickerView.swift
//  Remind
//
//  Created by t&a on 2023/03/08.
//

import SwiftUI

struct TimePickerView: View {
    // MARK: - 通知用時間ピッカー
    
    @Binding var time:Date
    
    var body: some View {
        DatePicker(selection: $time, in: DateTimeControlContainerView.dateRange, displayedComponents: [.hourAndMinute]) {
            Text("通知時間")
        }.padding()
        .environment(\.locale, Locale(identifier: "ja_JP"))
        .environment(\.calendar,DeviceSizeModel.calendar)
        .environment(\.timeZone, TimeZone(identifier: "Asia/Tokyo")!)
        .datePickerStyle(.compact)
    }
}

