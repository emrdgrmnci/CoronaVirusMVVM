//
//  ArticleViewModel.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 10.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

struct ArticleListViewModel {
    let articles: [News]
}

extension ArticleListViewModel {
    var numberOfSections: Int {
        return 1
    }

    func numberOfRowSection(_ section: Int) -> Int {
        return self.articles.count
    }

    func articleAtIndex(_ index: Int) -> ArticleViewModel{
        let article = self.articles[index]

        return ArticleViewModel(article)
    }
}

struct ArticleViewModel {
    private let article : News
}

extension ArticleViewModel {
    init (_ article: News) {
        self.article = article
    }
}

extension ArticleViewModel {
    var urlToImage: String {
        return self.article.urlToImage ?? ""
    }
    var title: String {
        return self.article.title ?? ""
    }
    var source: String {
        return self.article.author ?? ""
    }
    var publishedAt: String {
        return self.article.publishedAt ?? ""
    }
    var url: String {
        return self.article.url ?? ""
    }
}

