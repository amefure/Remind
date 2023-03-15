//
//  ContentView.swift
//  Remind
//
//  Created by t&a on 2022/10/04.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTag:Int = 1
    @State var isAlert:Bool = false
    
    var body: some View {
        VStack(spacing:0){
            
            // Header
            HeaderView()
            
            // Main Contents
            TabView(selection: $selectedTag) {
                EntryNotificationView().tabItem({
                    Image(systemName: "icloud.and.arrow.up.fill")
                }).tag(1)
                
                ListNotificationView().tabItem({
                    Image(systemName: "list.bullet")
                }).tag(2)
            }
        }.alert("アプリの通知設定が\nOFFになっています。\n端末の「設定」>「Remind」>「通知」から\n「通知を許可」の設定を変更してください。", isPresented: $isAlert){
        }.onAppear{
            // エラーが通知拒否ならばアラートを表示
            if ErrorViewModel().getError() == NotificationError.authorizationDenied {
                isAlert = true
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
