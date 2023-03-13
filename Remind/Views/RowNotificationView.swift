//
//  RowNotificationView.swift
//  Remind
//
//  Created by t&a on 2022/10/05.
//

import SwiftUI
import RealmSwift

struct RowNotificationView: View {
    
    // MARK: - ViewModels
    private let displayDateViewModel = DisplayDateViewModel()
    
    @ObservedRealmObject var notice:Notification
    
    var body: some View {
        HStack{
            Image(systemName: "checkmark.icloud.fill")
                .foregroundColor(Color("AccentColor"))
                .font(.system(size: 20))
            
            Text(displayDateViewModel.getAllDisplayFormatString(notice.date))
                .fontWeight(.bold)
                .font(.system(size: 12))
                .multilineTextAlignment(.trailing)
            
            Text(notice.body)
                .fontWeight(.bold)
                .foregroundColor(Color("AccentColor"))
                .font(.system(size: 20))
                .padding(.leading)
                .lineLimit(1)      
        }
    }
}

