//
//  MarketServices.swift
//  Assesment 2022
//
//  Created by RenhardJH on 24/03/22.
//

import Combine

class MarketServices: MarketProvider {

    func getMarkets(request: MarketRequestParam) -> AnyPublisher<[MarketResponse], Error> {
        Network.shared.connecting(urlRequest: request, model: [MarketResponse].self)
    }

    func getCoinDetail(request: CoinDetailRequestParam) -> AnyPublisher<CoinDetailResponse, Error> {
        Network.shared.connecting(urlRequest: request, model: CoinDetailResponse.self)
    }

    func getMarketCharts(request: MarketChartRequestParam) -> AnyPublisher<MarketChartResponse, Error> {
        Network.shared.connecting(urlRequest: request, model: MarketChartResponse.self)
    }
}
