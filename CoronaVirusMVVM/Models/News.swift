//
//  News.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 10.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

struct NewsResponse : Codable {
    let status : String?
    let totalResults : Int?
    let news : [News]?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalResults = "totalResults"
        case news = "articles"
    }
}

struct News: Codable {
    let source : Source?
    let author : String?
    let title : String?
    let description : String?
    let url : String?
    let urlToImage : String?
    let publishedAt : String?
    let content : String?
}

// MARK: - Source
struct Source : Codable {
    let id : String?
    let name : String?
}
