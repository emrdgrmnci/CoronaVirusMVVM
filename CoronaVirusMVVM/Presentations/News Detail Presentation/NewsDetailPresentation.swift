//
//  NewsDetailPresentation.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 13.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation
import UIKit

struct NewsDetailPresentation {

    let newsURL: String

    init(news: News) {
        newsURL = news.url ?? ""
    }
}

