//
//  CoinCryptoDetailViewModelTest.swift
//  Assesment 2022Tests
//
//  Created by RenhardJH on 18/05/22.
//

import XCTest
@testable import Assesment_2022
import Cuckoo
import Combine

class CoinCryptoDetailViewModelTest: XCTestCase {
    var mockService = MockMarketProvider()
    var viewModel: CoinCryptoDetailViewModel?
    let delay: TimeInterval = 1

    override func setUp() {
        super.setUp()
        viewModel = CoinCryptoDetailViewModel(service: mockService)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testGetCoinDetail() {
        let expected = expectation(description: "Observer Passed")

        guard let `viewModel` = viewModel else { return }
        viewModel.$coinData
            .receive(on: DispatchQueue.main)
            .sink { data in
                if data != nil {
                    XCTAssertNotNil(viewModel.coinData)
                    XCTAssertEqual(viewModel.coinData?.id, "bitcoin")
                    expected.fulfill()
                }
            }
            .store(in: &viewModel.subscriptions)

        stub(mockService) { stub in
            if let response = DummyData.shared.coinDetailModel {
                when(stub).getCoinDetail(request: any()).thenReturn(Future<CoinDetailResponse, Error> { resolve in resolve(.success(response)) }.eraseToAnyPublisher())
            }
        }

        viewModel.getCoinDetail()
        verify(mockService).getCoinDetail(request: any())

        wait(for: [expected], timeout: delay)
    }

    func testGetMarketCharts() {
        let expected = expectation(description: "Observer Passed")

        guard let `viewModel` = viewModel else { return }
        viewModel.$chartData
            .receive(on: DispatchQueue.main)
            .sink { data in
                if data != nil {
                    XCTAssertNotNil(viewModel.chartData)
                    XCTAssertEqual(viewModel.chartData?.prices?.first?.last, 29542.66109580348)
                    expected.fulfill()
                }
            }
            .store(in: &viewModel.subscriptions)

        stub(mockService) { stub in
            if let response = DummyData.shared.chartsModel {
                when(stub).getMarketCharts(request: any()).thenReturn(Future<MarketChartResponse, Error> { resolve in resolve(.success(response)) }.eraseToAnyPublisher())
            }
        }

        viewModel.getMarketCharts()
        verify(mockService).getMarketCharts(request: any())

        wait(for: [expected], timeout: delay)
    }
}
