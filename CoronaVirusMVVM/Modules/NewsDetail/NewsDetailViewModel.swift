//
//  NewsDetailViewModel.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 13.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

class NewsDetailViewModel: NewsDetailViewModelInterface {
    weak var delegate: NewsDetailViewModelDelegate?
    private let presentation: NewsDetailPresentation

    func load() {
        delegate?.prepareDetailViewInfos(presentation)
    }

    init(newsDetail: News) {
        self.presentation = NewsDetailPresentation(news: newsDetail)
    }
}

