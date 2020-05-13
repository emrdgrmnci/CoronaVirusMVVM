//
//  MainDetailViewModel.swift
//  CoronaVirusMVVM
//
//  Created by Ahmet Keskin on 10.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

class MainDetailViewModel: MainDetailViewModelInterface {
    weak var delegate: MainDetailViewModelDelegate?
    private let presentation: MainDetailPresentation

    func load() {
        delegate?.prepareDetailViewInfos(presentation)
    }

    init(countryDetail: Country) {
        self.presentation = MainDetailPresentation(country: countryDetail)
    }
}



