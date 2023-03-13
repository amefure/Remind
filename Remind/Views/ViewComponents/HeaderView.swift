//
//  HeaderView.swift
//  Remind
//
//  Created by t&a on 2023/03/11.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        Text("Remind")
            .foregroundColor(.white)
            .frame(width:DeviceSizeModel.deviceWidth)
            .padding()
            .background(Color("AccentColor"))
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
