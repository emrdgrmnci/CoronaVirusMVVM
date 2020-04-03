//
//  GlobalViewModel.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 3.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

//struct GlobalListViewModel {
//    let globalList: Global
//
//    func allCase() -> GlobalViewModel {
//        return GlobalViewModel(globalInfo: globalList)
//    }
//}

struct GlobalViewModel {
     let globalInfo: Global

    func getAllCases() -> GlobalViewModel {
        return GlobalViewModel(globalInfo: globalInfo)
    }
}

extension GlobalViewModel {
    init(_ globalInfo: Global) {
        self.globalInfo = globalInfo
    }
}

extension GlobalViewModel {
    var active: Int {
        return self.globalInfo.active!
    }
    var affectedCountries: Int {
        return self.globalInfo.affectedCountries!
    }
    var cases: Int {
        return self.globalInfo.cases!
    }
    var deaths: Int {
        return self.globalInfo.deaths!
    }
    var recovered: Int {
        return self.globalInfo.recovered!
    }
    var updated: Int {
        return self.globalInfo.updated!
    }
}

