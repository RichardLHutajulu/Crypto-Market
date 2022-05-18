//
//  MarketChartRequestParam.swift
//  Assesment 2022
//
//  Created by RenhardJH on 17/05/22.
//

import Foundation

struct MarketChartRequestParam: RequestParam {
    var url: String
    var method: URLMethod = .GET

    var id: String = ""
    var vs_currency: CurrencyType = .usd
    var days = "1"


    func getURLParam() -> String {
        let urlParam = url + "/\(id)/\("market_chart")"
            .add("vs_currency", value: vs_currency)
            .add("days", value: days)
        return urlParam
    }

    func getBody() -> [String : Any]? {
        return nil
    }

}
