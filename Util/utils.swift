//
//  utils.swift
//  APP2DB
//
//  Created by Kai on 2024/12/11.
//

import Foundation

// 扩展 Date 类型
extension Date {
    // 将日期转为 "yyyy-MM-dd" 格式的字符串
    func toDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
