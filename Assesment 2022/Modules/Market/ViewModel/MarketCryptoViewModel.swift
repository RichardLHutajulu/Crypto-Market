//
//  MarketCryptoViewModel.swift
//  Assesment 2022
//
//  Created by RenhardJH on 24/03/22.
//

import UIKit
import Combine

class MarketCryptoViewModel: BaseViewModel {
    private var service: MarketProvider

    var request = MarketRequestParam(url: Constants.markets_url)
    var subscriptions = Set<AnyCancellable>()
    @Published var marketData: [MarketResponse]?

    init(service: MarketProvider) {
        self.service = service
    }

    func getMarkets(reset: Bool = false) {
        if reset {
            request.page = 1
            marketData?.removeAll()
            presenter?.showLoadingView(true)
        }
        request.currency = Session.shared.getLocalize() == .id ? .idr : .usd
        service.getMarkets(request: request)
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
                }) { [weak self] markets in
                    if self?.marketData == nil {
                        self?.marketData = markets
                    } else {
                        self?.marketData?.append(contentsOf: markets)
                    }
                    if !markets.isEmpty {
                        self?.request.page += 1
                    }
                }
                .store(in: &subscriptions)
    }
}
