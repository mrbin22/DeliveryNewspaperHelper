//
//  MenuBar.swift
//  DeliveryNewspaperHelper
//
//  Created by cmStudent on 2024/11/04.
//

import SwiftUI

struct MenuBar: View {
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/,
                content:  {
            HomeView().tabItem { VStack {
                Image(systemName: "house")
                Text("ホーム")
            } }.tag(1)
            
            Text("Tab Content 2").tabItem { Image(systemName: "envelope")
                Text("メッセージ") }.tag(2)
            
            Text("Tab Content 2").tabItem { Image(systemName: "plus.circle")
                Text("追加") }.tag(3)
            
            Text("Tab Content 2").tabItem { Image(systemName: "person")
                Text("プロフィール") }.tag(4)
            
            Text("Tab Content 2").tabItem { Image(systemName: "gear")
                Text("設定") }.tag(5)
        })
    }
}

#Preview {
    MenuBar()
}
