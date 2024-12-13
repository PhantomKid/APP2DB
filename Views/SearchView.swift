//
//  SearchView.swift
//  APP2DB
//
//  Created by Kai on 2024/12/11.
//

import SwiftUI

struct SearchView: View {
    let minDate = Calendar.current.date(from: DateComponents(year: 2006, month: 9, day: 9))!
    let maxDate = Calendar.current.date(from: DateComponents(year: 2022, month: 12, day: 29))!
    
    @State private var sname: String = ""
    @State private var researchDirection: String = ""
    @State private var resLimit: String = ""
    @State private var yearStart: String = "2005"
    @State private var yearEnd: String = "2021"
    @State private var reportContent: String = ""
    @State private var reportStart: Date = Calendar.current.date(from: DateComponents(year: 2006, month: 9, day: 9))!
    @State private var reportEnd: Date = Calendar.current.date(from: DateComponents(year: 2022, month: 12, day: 29))!
    @State private var logic: String = "AND"
    @State private var order: String = "ASC"

    @State private var resultData: [Person] = []
    
    // 构建查询参数并发送请求
    func performQuery() {
        var parameters: [String: String] = [
            "sname": sname,
            "researchDirection": researchDirection,
            "resLimit": resLimit,
            "yearStart": yearStart,
            "yearEnd": yearEnd,
            "reportContent": reportContent,
            "logic": logic,
            "order": order
        ]
        
        parameters["reportStart"] = reportStart.toDateString()
        parameters["reportEnd"] = reportEnd.toDateString()

        NetworkManager.shared.queryData(endpoint: "/query", parameters: parameters) { (result: Result<[Person], Error>) in
            switch result {
            case .success(let results):
                resultData = results
            case .failure(let error):
                print("请求失败：\(error)")
            }
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("查询条件")) {
                    TextField("姓名", text: $sname)
                    TextField("研究方向", text: $researchDirection)
                    TextField("报告内容", text: $reportContent)
                    TextField("返回个数", text: $resLimit)

                    HStack {
                        Picker("入学年份", selection: $yearStart) {
                            ForEach(2005...2022, id: \.self) { year in
                                Text("\(year)").tag("\(year)")
                            }
                        }
                        Picker("到", selection: $yearEnd) {
                            ForEach(2005...2022, id: \.self) { year in
                                Text("\(year)").tag("\(year)")
                            }
                        }
                    }
                    
                    HStack {
                        DatePicker("报告时间", selection: $reportStart, in: minDate...maxDate, displayedComponents: [.date])
                        DatePicker("到", selection: $reportEnd, in: minDate...maxDate, displayedComponents: [.date])
                    }
                    
                    HStack {
                        Text("逻辑关系")
                        Picker("逻辑关系", selection: $logic) {
                            Text("与（AND）").tag("AND")
                            Text("或（OR）").tag("OR")
                        }
                    }

                    HStack {
                        Text("排序顺序")
                        Picker("排序顺序", selection: $order) {
                            Text("升序").tag("ASC")
                            Text("降序").tag("DESC")
                        }
                    }
                }

                Section {
                    NavigationLink("查询", destination: ResultView(resultData: resultData))
                }
            }
            .navigationTitle("查询页")
//            .onChange(of: sname) { _ in
//                resultData = [] // 清空查询结果
//            }
            .onDisappear {
                performQuery() // 点击查询按钮时发送请求
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
