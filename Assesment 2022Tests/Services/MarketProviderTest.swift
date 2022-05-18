//
//  MarketProviderTest.swift
//  Assesment 2022Tests
//
//  Created by RenhardJH on 18/05/22.
//

import XCTest
@testable import Assesment_2022
import Cuckoo
import Combine

class MarketProviderTest: XCTestCase {
    var mockService = MockMarketProvider()
    var subscriptions = Set<AnyCancellable>()
    let delay: TimeInterval = 1

    func testGetMarkets() {
        let expected = expectation(description: "Observer Passed")

        let request = MarketRequestParam(url: Constants.markets_url,
                                         currency: .usd)

        let expectedResponse = DummyData.shared.marketModel ?? []
        stub(mockService) { stub in
            when(stub).getMarkets(request: any()).thenReturn(Future<[MarketResponse], Error> { resolve in resolve(.success(expectedResponse)) }.eraseToAnyPublisher())
        }

        mockService.getMarkets(request: request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                    switch completion {
                    case let .failure(error):
                        if let responseError = (error as? ResponseError)?.error {
                            XCTFail(responseError)
                        } else {
                            XCTFail(error.localizedDescription)
                        }
                    case .finished:
                        expected.fulfill()
                    }
                }) { actualResponse in
                    XCTAssertEqual(expectedResponse.first?.id, actualResponse.first?.id)
                }
                .store(in: &subscriptions)

        wait(for: [expected], timeout: delay)
    }

    func testGetCoinDetail() {
        let expected = expectation(description: "Observer Passed")

        let request = CoinDetailRequestParam(url: Constants.coin_detail_url)

        guard let expectedResponse = DummyData.shared.coinDetailModel else { return }
        stub(mockService) { stub in
            when(stub).getCoinDetail(request: any()).thenReturn(Future<CoinDetailResponse, Error> { resolve in resolve(.success(expectedResponse)) }.eraseToAnyPublisher())
        }

        mockService.getCoinDetail(request: request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                    switch completion {
                    case let .failure(error):
                        if let responseError = (error as? ResponseError)?.error {
                            XCTFail(responseError)
                        } else {
                            XCTFail(error.localizedDescription)
                        }
                    case .finished:
                        expected.fulfill()
                    }
                }) { actualResponse in
                    XCTAssertEqual(expectedResponse.id, actualResponse.id)
                }
                .store(in: &subscriptions)

        wait(for: [expected], timeout: delay)
    }

    func testGetMarketCharts() {
        let expected = expectation(description: "Observer Passed")

        let request = MarketChartRequestParam(url: Constants.coin_detail_url)

        guard let expectedResponse = DummyData.shared.chartsModel else { return }
        stub(mockService) { stub in
            when(stub).getMarketCharts(request: any()).thenReturn(Future<MarketChartResponse, Error> { resolve in resolve(.success(expectedResponse)) }.eraseToAnyPublisher())
        }

        mockService.getMarketCharts(request: request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                    switch completion {
                    case let .failure(error):
                        if let responseError = (error as? ResponseError)?.error {
                            XCTFail(responseError)
                        } else {
                            XCTFail(error.localizedDescription)
                        }
                    case .finished:
                        expected.fulfill()
                    }
                }) { actualResponse in
                    XCTAssertEqual(expectedResponse.prices?.first?.last, actualResponse.prices?.first?.last)
                }
                .store(in: &subscriptions)

        wait(for: [expected], timeout: delay)
    }
}
