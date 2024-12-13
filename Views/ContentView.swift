//
//  ContentView.swift
//  APP2DB
//
//  Created by Kai on 2024/12/11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            StatView()
                .tabItem {
                    Label("统计页", systemImage: "chart.bar.fill")
                }

            SearchView()
                .tabItem {
                    Label("查询页", systemImage: "magnifyingglass")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
