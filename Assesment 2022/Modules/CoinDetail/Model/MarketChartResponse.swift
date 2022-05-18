//
//  MarketChartResponse.swift
//  Assesment 2022
//
//  Created by RenhardJH on 17/05/22.
//

import Foundation

struct MarketChartResponse: Codable {
    let prices, marketCaps, totalVolumes: [[Double]]?

    enum CodingKeys: String, CodingKey {
        case prices
        case marketCaps = "market_caps"
        case totalVolumes = "total_volumes"
    }
}
