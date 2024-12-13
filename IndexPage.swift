//
//  IndexPage.swift
//  APP2DB
//
//  Created by Kai on 2024/12/11.
//

import SwiftUI

struct IndexPage: View {
    @State private var isModalVisible = false
    @State private var modalTitle = ""
    @State private var modalData: [ModalItem] = []
    
    var body: some View {
        VStack {
            Text("统计选项")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            NavigationLink(destination: ConditionPage()) {
                Text("查询条件")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                showCareerStats()
            }) {
                Text("毕业去向统计")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                showResearchStats()
            }) {
                Text("研究方向统计")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            // Modal for displaying stats
            if isModalVisible {
                ModalView(isVisible: $isModalVisible, title: $modalTitle, data: $modalData)
            }
        }
        .padding()
    }
    
    // Show career stats
    func showCareerStats() {
        let urlString = "http://192.168.9.104:3000/stats/career"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // API request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let result = try JSONDecoder().decode([CareerStat].self, from: data)
                let formattedData = result.map { ModalItem(label: $0.career ?? "未知", value: "\($0.numPeople) 人") }
                DispatchQueue.main.async {
                    self.modalTitle = "毕业去向统计"
                    self.modalData = formattedData
                    self.isModalVisible = true
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        
        task.resume()
    }
    
    // Show research stats
    func showResearchStats() {
        let urlString = "http://192.168.9.104:3000/stats/research"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(ResearchStatResponse.self, from: data)
                let formattedData = result.results.map { ModalItem(label: $0.field ?? "未知", value: "\($0.numPeople) 人") }
                DispatchQueue.main.async {
                    self.modalTitle = "研究方向统计"
                    self.modalData = formattedData
                    self.isModalVisible = true
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        
        task.resume()
    }
}

struct ModalItem {
    let label: String
    let value: String
}

struct ModalView: View {
    @Binding var isVisible: Bool
    @Binding var title: String
    @Binding var data: [ModalItem]
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            List(data, id: \.label) { item in
                Text("\(item.label): \(item.value)")
            }
            
            Button("关闭") {
                isVisible = false
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
        .frame(width: 300, height: 400)
        .overlay(
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

// CareerStat: 解析毕业去向的统计数据
struct CareerStat: Codable {
    let career: String?
    let numPeople: Int
    
    // 映射后端的 num_people 到 numPeople
    enum CodingKeys: String, CodingKey {
        case career = "career"
        case numPeople = "num_people" // 映射后端的 num_people 到 numPeople
    }
}

// ResearchStat: 解析研究方向的数据项
struct ResearchStat: Codable {
    let field: String?
    let numPeople: Int
    
    // 映射后端的 num_people 到 numPeople
    enum CodingKeys: String, CodingKey {
        case field = "field"
        case numPeople = "num_people" // 映射后端的 num_people 到 numPeople
    }
}

// ResearchStatResponse: 包装研究方向统计的响应体
struct ResearchStatResponse: Codable {
    let results: [ResearchStat]
}
