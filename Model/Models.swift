//
//  Models.swift
//  APP2DB
//
//  Created by Kai on 2024/12/11.
//

import Foundation

struct CareerStat: Codable {
    var career: String?
    var numPeople: Int
    
    // 使用 enum CodingKeys 来映射 JSON 中的字段
    enum CodingKeys: String, CodingKey {
        case career = "career"
        case numPeople = "num_people"
    }
}

struct ResearchStat: Codable {
    var field: String?
    var numPeople: Int
    
    // 使用 enum CodingKeys 来映射 JSON 中的字段
    enum CodingKeys: String, CodingKey {
        case field = "field"
        case numPeople = "num_people"
    }
}

struct ResearchStatResponse: Codable {
    var results: [ResearchStat]
    var maxFields: [ResearchStat]
    var minFields: [ResearchStat]
}

struct Person: Codable, Identifiable {
    var id: String
    var name: String
    var admissionYear: String
    var degree: String
    var researchDirection: String?
    var career: String?
    var group: String?
    
    // 使用 enum CodingKeys 来映射 JSON 中的字段
    enum CodingKeys: String, CodingKey {
        case id = "speaker_id"
        case name = "name"
        case admissionYear = "admission_date"
        case degree = "postgraduate"
        case researchDirection = "research_fields"
        case career = "career_development"
        case group = "group_name"
    }
}
