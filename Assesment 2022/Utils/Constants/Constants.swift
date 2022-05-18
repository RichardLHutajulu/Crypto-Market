//
//  Constants.swift
//  Assesment 2022
//
//  Created by RenhardJH on 25/03/22.
//

import Foundation

class Constants {
    private static var server = "https://api.coingecko.com"
    static var baseURL = server + "/api/v3/"
    static var markets_url = baseURL + "coins/markets"
    static var coin_detail_url = baseURL + "coins"
}
