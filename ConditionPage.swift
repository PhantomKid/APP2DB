//
//  ConditionPage.swift
//  APP2DB
//
//  Created by Kai on 2024/12/11.
//

import SwiftUI

struct ConditionPage: View {
    @State private var sname = ""
    @State private var researchDirection = ""
    @State private var resLimit = ""
    @State private var yearStart = ""
    @State private var yearEnd = ""
    @State private var reportContent = ""
    @State private var reportStart = ""
    @State private var reportEnd = ""
    @State private var booleanLogic = "AND"
    @State private var orderOfYear = "升序"
    
    @State private var yearRange: [String] = []
    @State private var result: [Student] = []
    
    var body: some View {
        VStack {
            // Input Fields
            TextField("姓名", text: $sname)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("研究方向", text: $researchDirection)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("返回个数", text: $resLimit)
                .padding()
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Picker("入学年份", selection: $yearStart) {
                ForEach(yearRange, id: \.self) {
                    Text($0)
                }
            }
            .padding()
            
            Picker("结束年份", selection: $yearEnd) {
                ForEach(yearRange, id: \.self) {
                    Text($0)
                }
            }
            .padding()
            
            Button(action: {
                onQuery()
            }) {
                Text("查询")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            // Results List
            List(result) { student in
                VStack(alignment: .leading) {
                    Text("学号: \(student.speakerID)")
                    Text("姓名: \(student.name)")
                    Text("入学年份: \(student.admissionDate)")
                    Text("学历: \(student.postgraduate)")
                    Text("研究方向: \(student.researchFields)")
                    Text("职业岗位: \(student.careerDevelopment)")
                    Text("组名: \(student.groupName)")
                }
                .padding()
            }
        }
        .onAppear {
            // Initialize yearRange or any other setup
            yearRange = Array(2005...2021).map { String($0) }
        }
        .padding()
    }
    
    // Query function
    func onQuery() {
        let urlString = "http://192.168.9.104:3000/query"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Create query parameters
        let parameters: [String: Any] = [
            "sname": sname,
            "researchDirection": researchDirection,
            "resLimit": resLimit,
            "yearStart": yearStart,
            "yearEnd": yearEnd,
            "reportContent": reportContent,
            "reportStart": reportStart,
            "reportEnd": reportEnd,
            "logic": booleanLogic,
            "order": orderOfYear
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        
        // Networking logic for query
    }
}

struct Student: Identifiable, Codable {
    var id: String
    var speakerID: String
    var name: String
    var admissionDate: String
    var postgraduate: String
    var researchFields: String
    var careerDevelopment: String
    var groupName: String
}

