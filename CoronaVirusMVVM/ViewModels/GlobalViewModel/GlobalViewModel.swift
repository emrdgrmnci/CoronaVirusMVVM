//
//  GlobalViewModel.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 3.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

struct GlobalViewModel {
     let globalInfo: Global

    func getAllCases() -> GlobalViewModel {
        return GlobalViewModel(globalInfo: globalInfo)
    }
}

extension GlobalViewModel {

    var active: Int {
        return globalInfo.active!
    }

    var affectedCountries: Int {
        return globalInfo.affectedCountries!
    }

    var cases: Int {
        return globalInfo.cases!
    }

    var deaths: Int {
        return globalInfo.deaths!
    }

    var recovered: Int {
        return globalInfo.recovered!
    }

    var updated: Int {
        return globalInfo.updated!
    }
}
