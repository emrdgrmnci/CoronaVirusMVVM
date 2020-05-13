//
//  NewsTableViewCell.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 10.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit
import SDWebImage
import Foundation

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsContentLabel:  UILabel!
    @IBOutlet weak var newsSourceLabel:   UILabel!
    @IBOutlet weak var newsPublishedLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        showAnimatedSkeleton()
    }

    func hideAnimation() {
        hideSkeleton()
    }

    func configure(with news: NewsResponse) {
        let news = news.news
        newsImageView.sd_setImage(with: URL(string: "\(String(describing: news))"), placeholderImage: UIImage(named: "placeholder.png"))
        newsContentLabel.text = news.title
        newsSourceLabel.text = news.source?.name
        newsPublishedLabel.text = formattedDate(of: news.publishedAt ?? "12-04-2020")
    }

    public func formattedDate(of publishedAt: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        let publishedDate = formatter.date(from: publishedAt)
        formatter.dateFormat = "dd-MMMM-yyyy"
        let formattedDate = formatter.string(from: publishedDate!)
        return formattedDate
    }
}
