//
//  Assesment_2022Tests.swift
//  Assesment 2022Tests
//
//  Created by RenhardJH on 24/03/22.
//

import XCTest
@testable import Assesment_2022
import Cuckoo
import Combine

class MarketCryptoViewModelTest: XCTestCase {
    var mockService = MockMarketProvider()
    var viewModel: MarketCryptoViewModel?
    let delay: TimeInterval = 1

    override func setUp() {
        super.setUp()
        viewModel = MarketCryptoViewModel(service: mockService)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testGetMarkets() {
        let expected = expectation(description: "Observer Passed")

        guard let `viewModel` = viewModel else { return }
        viewModel.$marketData
            .receive(on: DispatchQueue.main)
            .sink { data in
                if data != nil {
                    XCTAssertNotNil(viewModel.marketData)
                    XCTAssertEqual(viewModel.marketData?.first?.id, "bitcoin")
                    expected.fulfill()
                }
            }
            .store(in: &viewModel.subscriptions)

        stub(mockService) { stub in
            when(stub).getMarkets(request: any()).thenReturn(Future<[MarketResponse], Error> { resolve in resolve(.success(DummyData.shared.marketModel ?? [])) }.eraseToAnyPublisher())
        }

        viewModel.getMarkets(reset: true)
        verify(mockService).getMarkets(request: any())

        wait(for: [expected], timeout: delay)
    }
}
