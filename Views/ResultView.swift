//
//  ResultView.swift
//  APP2DB
//
//  Created by Kai on 2024/12/11.
//

import SwiftUI

struct ResultView: View {
    var resultData: [Person]

    var body: some View {
        NavigationView {
            VStack {
                Text("查询结果")
                    .font(.title)
                    .padding()
                
                List(resultData) { person in
                    VStack(alignment: .leading) {
                        Text("学号: \(person.id)")
                            .font(.subheadline)
                        Text("姓名: \(person.name)")
                            .font(.headline)
                        Text("入学年份: \(person.admissionYear)")
                        Text("学历: \(person.degree)")
                        Text("研究方向: \(person.researchDirection ?? "未知")" )
                        Text("职业岗位: \(person.career ?? "未知")")
                        Text("组名: \(person.group ?? "未知")")
                    }
                    .padding()
                }
            }
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(resultData: [
            Person(id: "1", name: "张三", admissionYear: "2018", degree: "硕士", researchDirection: "计算机科学", career: "软件工程师", group: "A组"),
            Person(id: "2", name: "李四", admissionYear: "2019", degree: "博士", researchDirection: "人工智能", career: "研究员", group: "B组")
        ])
    }
}
