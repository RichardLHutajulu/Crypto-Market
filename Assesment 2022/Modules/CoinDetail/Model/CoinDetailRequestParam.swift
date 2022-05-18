//
//  CoinDetailRequestParam.swift
//  Assesment 2022
//
//  Created by RenhardJH on 26/04/22.
//

import Foundation

struct CoinDetailRequestParam: RequestParam {
    var url: String
    var method: URLMethod = .GET

    var id: String = ""
    var localization = true
    var tickers = true
    var market_data = true
    var community_data = false
    var developer_data = false

    func getURLParam() -> String {
        let urlParam = url + "/\(id)"
            .add("localization", value: localization)
            .add("tickers", value: tickers)
            .add("market_data", value: market_data)
            .add("community_data", value: community_data)
            .add("developer_data", value: developer_data)
        return urlParam
    }

    func getBody() -> [String : Any]? {
        return nil
    }

}
