//
//  StatView.swift
//  APP2DB
//
//  Created by Kai on 2024/12/11.
//

import SwiftUI

struct StatView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("毕业去向统计", destination: CareerStatView())
                    .padding()

                NavigationLink("研究方向统计", destination: ResearchStatView())
                    .padding()
            }
            .navigationTitle("统计页")
        }
    }
}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        StatView()
    }
}

