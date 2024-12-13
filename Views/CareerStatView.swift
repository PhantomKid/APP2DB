//
//  CareerStatView.swift
//  APP2DB
//
//  Created by Kai on 2024/12/11.
//

import SwiftUI

struct CareerStatView: View {
    @State private var careerStats: [CareerStat] = []
    @State private var selectedCareer: String? = nil
    
    // 从后端获取毕业去向统计数据
    func fetchCareerStats() {
        NetworkManager.shared.fetchData(endpoint: "/stats/career") { (result: Result<[CareerStat], Error>) in
            switch result {
            case .success(let stats):
                careerStats = stats
            case .failure(let error):
                print("请求失败：\(error)")
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // 标题部分，居中显示
                Text("毕业去向统计")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                
                // 显示统计结果的列表
                List(careerStats, id: \.career) { stat in
                    VStack(alignment: .leading) {
                        Text(stat.career ?? "未知")
                            .font(.headline)
                        Text("人数: \(stat.numPeople)")
                    }
                    .padding()
                }
            }
            .onAppear {
                fetchCareerStats() // 页面加载时获取数据
            }
        }
    }
}

struct CareerStatView_Previews: PreviewProvider {
    static var previews: some View {
        CareerStatView()
    }
}
