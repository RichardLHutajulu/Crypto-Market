//
//  DummyData.swift
//  Assesment 2022Tests
//
//  Created by RenhardJH on 18/05/22.
//

import Foundation

class DummyData {
    static var shared = DummyData()

    var marketModel: [MarketResponse]? {
        get {
            if let path = Bundle(for: type(of: self)).path(forResource: "response_get_markets", ofType: "json") {
                do {
                      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                      if let model = try? JSONDecoder().decode([MarketResponse].self, from: data) {
                         return model
                      }
                  } catch {
                      return nil
                  }
            }
            return nil
        }
    }

    var coinDetailModel: CoinDetailResponse? {
        get {
            if let path = Bundle(for: type(of: self)).path(forResource: "response_get_coindetail", ofType: "json") {
                do {
                      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                      if let model = try? JSONDecoder().decode(CoinDetailResponse.self, from: data) {
                         return model
                      }
                  } catch {
                      return nil
                  }
            }
            return nil
        }
    }

    var chartsModel: MarketChartResponse? {
        get {
            if let path = Bundle(for: type(of: self)).path(forResource: "response_get_charts", ofType: "json") {
                do {
                      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                      if let model = try? JSONDecoder().decode(MarketChartResponse.self, from: data) {
                         return model
                      }
                  } catch {
                      return nil
                  }
            }
            return nil
        }
    }
}
