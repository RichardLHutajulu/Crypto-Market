//
//  MarketRequestParam.swift
//  Assesment 2022
//
//  Created by RenhardJH on 25/03/22.
//

import Foundation

struct MarketRequestParam: RequestParam {
    var url: String
    var method: URLMethod = .GET

    var currency: CurrencyType = .usd
    var page = 1
    var perPage = 15
    var orderBy: MarketOrderBy = .market_cap_desc
    var sparkline = true

    func getURLParam() -> String {
        let urlParam = url
            .add("vs_currency", value: currency)
            .add("page", value: page)
            .add("per_page", value: perPage)
            .add("order", value: orderBy)
            .add("sparkline", value: sparkline)
        return urlParam
    }

    func getBody() -> [String : Any]? {
        return nil
    }

}

enum CurrencyType: String {
    case usd
    case idr
}

enum MarketOrderBy: String {
    case market_cap_asc, market_cap_desc
    case volume_asc, volume_desc
}
