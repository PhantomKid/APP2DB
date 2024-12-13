//
//  ResultPage.swift
//  APP2DB
//
//  Created by Kai on 2024/12/11.
//

import SwiftUI

struct ResultPage: View {
    var data: [Student]
    var noResults: Bool = false
    
    var body: some View {
        VStack {
            if noResults {
                Text("无匹配结果")
                    .font(.title)
                    .padding()
            } else {
                List(data) { student in
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
        }
        .padding()
    }
}
