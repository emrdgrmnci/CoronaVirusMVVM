//
//  APIService.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 2.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

class APIService {

    func getCountries(url: URL, completion: @escaping CallBack<[Country]?>) {

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {

                let countryList = try? JSONDecoder().decode([Country].self, from: data)
                completion(countryList)
            }

        }.resume()

    }

    func getGlobalCases(url: URL, completion: @escaping CallBack<Global?>) {

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {

                let global = try? JSONDecoder().decode(Global.self, from: data)
                if let global = global {
                    completion(global)
                    print(global)
                }
            }

        }.resume()

    }

    func getNews(url: URL, completion: @escaping ([Article]?) -> ()) {

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                print(error.localizedDescription)
            }
            else if let data = data {
                let articleList = try? JSONDecoder().decode(NewsResponse.self, from: data)

                if let articleList = articleList {
                    completion(articleList.articles)
                }
            }
        }.resume()
    }
}
