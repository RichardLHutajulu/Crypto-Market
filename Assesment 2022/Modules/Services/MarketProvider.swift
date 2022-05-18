//
//  MarketProvider.swift
//  Assesment 2022
//
//  Created by RenhardJH on 25/03/22.
//

import Combine

protocol MarketProvider {

    func getMarkets(request: MarketRequestParam) -> AnyPublisher<[MarketResponse], Error>
    func getCoinDetail(request: CoinDetailRequestParam) -> AnyPublisher<CoinDetailResponse, Error>
    func getMarketCharts(request: MarketChartRequestParam) -> AnyPublisher<MarketChartResponse, Error>
}
