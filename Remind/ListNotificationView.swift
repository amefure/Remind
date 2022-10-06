//
//  ListNotificationView.swift
//  Remind
//
//  Created by t&a on 2022/10/04.
//

import SwiftUI
import RealmSwift
struct ListNotificationView: View {
    
    // MARK: - Models
    let manager = NotificationRequestManager()
    // 当日の日付よりも後にセットされている通知のみ表示かつ日付の新しい古い順にソート
    @ObservedResults(Notification.self,where: {$0.date >= Date()},sortDescriptor:SortDescriptor(keyPath: "date", ascending: true)) var notification
    
    // MARK: - View
    @State var isAlert:Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(notification){ notice in
                        RowNotificationView(notice: notice)
                    }.onDelete(perform: { index in
                        
                        manager.removeNotificationRequest(id:notification[index.first!].id)
                        $notification.remove(atOffsets: index)
                        isAlert = true
                    })
                }.alert("Remindを削除しました。", isPresented: $isAlert, actions: {})
                
                Spacer()
                
                AdMobBannerView().frame(height:30).padding(.bottom)
            }.navigationTitle("RemindList")
                
        }.navigationViewStyle(.stack)
    }
}

struct ListNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        ListNotificationView()
    }
}
