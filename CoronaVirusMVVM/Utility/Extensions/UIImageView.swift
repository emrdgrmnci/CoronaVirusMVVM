//
//  UIImage.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 12.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(with path: String?, placeholder: String = "placeholder") {
        guard let path = path, let url = URL(string: path) else { return }
        self.sd_setImage(with: url, placeholderImage: UIImage(named: placeholder))
    }
}
