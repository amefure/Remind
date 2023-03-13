//
//  ContentView.swift
//  Remind
//
//  Created by t&a on 2022/10/04.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTag:Int = 1

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
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
