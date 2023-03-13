//
//  OldNotification.swift
//  Remind
//
//  Created by t&a on 2022/11/08.
//

import SwiftUI
import RealmSwift

struct OldNotification: View {
    
    // MARK: - ViewModels
    private let realmDataBaseViewModel = RealmDataBaseViewModel()
    
    // 当日の日付よりも後にセットされている通知のみ表示かつ日付の新しい古い順にソート
    @ObservedResults(Notification.self,where:{ $0.date <= Date()},
                     sortDescriptor:SortDescriptor(keyPath: "date",
                                                   ascending: false)) var notification
    
    @State var isAlert:Bool = false
    
    var body: some View {
        VStack{
            
            List{
                if notification.count == 0{
                    Text("古いRemindはありません").listRowBackground(Color.clear)
                }else{
                    ForEach(notification){ notice in
                        RowNotificationView(notice: notice)
                    }
                }
            }
            
            Spacer()
            
            AdMobBannerView().frame(height:50)
            
        }.alert("古いRemindを\n全て削除しますか？", isPresented: $isAlert){
            
            // MARK: -
            Button(role:.destructive,action: {
                realmDataBaseViewModel.deleteAllOldRecord()
            }, label: {
                Text("削除")
            })
        }
        .navigationTitle("Old Remind")
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button(action: {
                    isAlert = true
                }, label: {
                    Image(systemName: "trash").foregroundColor(.red)
                })
            })
        })
    }
}

struct OldNotification_Previews: PreviewProvider {
    static var previews: some View {
        OldNotification()
    }
}
