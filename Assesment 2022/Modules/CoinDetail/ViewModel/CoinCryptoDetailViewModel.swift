//
//  CoinCryptoDetailViewModel.swift
//  Assesment 2022
//
//  Created by RenhardJH on 26/04/22.
//

import UIKit
import Combine
import DSFSparkline

class CoinCryptoDetailViewModel: BaseViewModel {
    private var service: MarketProvider

    var request = CoinDetailRequestParam(url: Constants.coin_detail_url)
    var requestChart = MarketChartRequestParam(url: Constants.coin_detail_url)
    var subscriptions = Set<AnyCancellable>()

    @Published var coinData: CoinDetailResponse?
    @Published var chartData: MarketChartResponse?

    var sparkds = DSFSparkline.DataSource(windowSize: 200, range: -100000 ... 100000)
    var coinName = ""
    var priceChangePercentage: Double = 0

    init(service: MarketProvider) {
        self.service = service
    }

    func getCoinDetail() {
        presenter?.showLoadingView(true)
        service.getCoinDetail(request: request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case let .failure(error):
                        if let responseError = (error as? ResponseError)?.error {
                            self?.presenter?.onNetworkError?(message: responseError)
                        }
                    case .finished:
                        self?.presenter?.showLoadingView(false)
                    }
                }) { [weak self] data in
                    self?.coinData = data
                }
                .store(in: &subscriptions)
    }

    func getMarketCharts(days: MarketChartDays = .day) {
        requestChart.days = days
        presenter?.showLoadingView(true)
        service.getMarketCharts(request: requestChart)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case let .failure(error):
                        if let responseError = (error as? ResponseError)?.error {
                            self?.presenter?.onNetworkError?(message: responseError)
                        }
                    case .finished:
                        self?.presenter?.showLoadingView(false)
                    }
                }) { [weak self] data in
                    self?.chartData = data
                }
                .store(in: &subscriptions)
    }
}
