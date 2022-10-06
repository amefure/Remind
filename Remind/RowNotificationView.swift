//
//  RowNotificationView.swift
//  Remind
//
//  Created by t&a on 2022/10/05.
//

import SwiftUI
import RealmSwift

struct RowNotificationView: View {
    
    func df() -> DateFormatter{
        let df = DateFormatter()
        df.calendar = Calendar(identifier: .gregorian)
        df.locale = Locale(identifier: "ja_JP")
        df.timeZone = TimeZone(identifier: "Asia/Tokyo")
        df.dateFormat = "yyyy年\nMM月dd日\nH時mm分"
        return df
    }
    
    @ObservedRealmObject var notice:Notification
    
    var body: some View {
        HStack{
            Image(systemName: "checkmark.icloud.fill").foregroundColor(Color("AccentColor")).font(.system(size: 20))
            Text(df().string(from: notice.date)).fontWeight(.bold).font(.system(size: 12)).multilineTextAlignment(.trailing)
            Text(notice.body).fontWeight(.bold).font(.system(size: 20)).padding(.leading).lineLimit(1).foregroundColor(Color("AccentColor"))
        }
    }
}

