//
//  NotificationTextFieldView.swift
//  Remind
//
//  Created by t&a on 2023/03/08.
//

import SwiftUI

struct NotificationTextFieldView: View {
    // MARK: - 通知用内容入力欄
    
    @Binding var text:String
    
    var body: some View {
        TextField("通知内容", text: $text)
            .textFieldStyle(.roundedBorder)
            .padding()
            .background(Color(red: 0.9, green: 0.9, blue: 0.9))
            .cornerRadius(10)
            .padding()
            .environment(\.colorScheme, .light)
    }
}

