//
//  ExtensionViewModifier.swift
//  Remind
//
//  Created by t&a on 2023/03/13.
//

import SwiftUI
 
struct MainButton:ViewModifier{
    func body(content: Content) -> some View {
        content.padding()
            .background(Color(red: 0.9, green: 0.9, blue: 0.9))
            .cornerRadius(10)
            .shadow(color: .gray,radius: 3, x: 2, y: 2)
    }
}

extension View {
    func mainButton()-> some View{
        modifier(MainButton())
    }
}
