//
//  ResearchStatView.swift
//  APP2DB
//
//  Created by Kai on 2024/12/11.
//

import SwiftUI

struct ResearchStatView: View {
    @State private var researchStats: [ResearchStat] = []
    @State private var maxFields: [ResearchStat] = []
    @State private var minFields: [ResearchStat] = []
    
    // 从后端获取研究方向统计数据
    func fetchResearchStats() {
        NetworkManager.shared.fetchData(endpoint: "/stats/research") { (result: Result<ResearchStatResponse, Error>) in
            switch result {
            case .success(let response):
                researchStats = response.results
                maxFields = response.maxFields
                minFields = response.minFields
            case .failure(let error):
                print("请求失败：\(error)")
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("研究方向统计")
                    .font(.title)
                    .padding()
                
                List(researchStats, id: \.field) { stat in
                    VStack(alignment: .leading) {
                        Text(stat.field ?? "未知")
                            .font(.headline)
                        Text("人数: \(stat.numPeople)")
                    }
                    .padding()
                }
            }
            .onAppear {
                fetchResearchStats() // 页面加载时获取数据
            }
        }
    }
}

struct ResearchStatView_Previews: PreviewProvider {
    static var previews: some View {
        ResearchStatView()
    }
}



