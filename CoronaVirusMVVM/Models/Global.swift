//
//  Global.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 3.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

struct Global: Decodable {
    var cases: Int?
    var deaths: Int?
    var recovered: Int?
    var updated: Int?
    var active: Int?
    var affectedCountries: Int?
}
