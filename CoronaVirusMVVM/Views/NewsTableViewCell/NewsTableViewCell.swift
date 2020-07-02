//
//  NewsTableViewCell.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 14.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsContentLabel: UILabel!
    @IBOutlet weak var newsSourceLabel: UILabel!
    @IBOutlet weak var newsPublishedLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        showAnimatedSkeleton()

    }
    func hideAnimation() {
        hideSkeleton()
    }

    func configure(with news: News) {
        newsImageView.setImage(with: news.urlToImage)
        newsContentLabel.text = news.content
        newsSourceLabel.text = news.source?.name
        newsPublishedLabel.text = news.publishedAt
    }
}
