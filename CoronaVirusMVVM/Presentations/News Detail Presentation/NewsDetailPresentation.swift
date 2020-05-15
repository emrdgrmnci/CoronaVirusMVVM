//
//  NewsDetailPresentation.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 15.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation
import WebKit
import Foundation

struct NewsDetailPresentation {
    let newsDetailURL: String

    init(news: News) {
        newsDetailURL = news.url ?? "https://www.google.com"
    }
}
