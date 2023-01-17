// MARK: - Mocks generated from file: Assesment 2022/Modules/Services/MarketProvider.swift at 2023-01-17 09:38:01 +0000

//
//  MarketProvider.swift
//  Assesment 2022
//
//  Created by RenhardJH on 25/03/22.
//

import Cuckoo
@testable import Assesment_2022

import Combine






 class MockMarketProvider: MarketProvider, Cuckoo.ProtocolMock {
    
     typealias MocksType = MarketProvider
    
     typealias Stubbing = __StubbingProxy_MarketProvider
     typealias Verification = __VerificationProxy_MarketProvider

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: MarketProvider?

     func enableDefaultImplementation(_ stub: MarketProvider) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     func getMarkets(request: MarketRequestParam) -> AnyPublisher<[MarketResponse], Error> {
        
    return cuckoo_manager.call(
    """
    getMarkets(request: MarketRequestParam) -> AnyPublisher<[MarketResponse], Error>
    """,
            parameters: (request),
            escapingParameters: (request),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMarkets(request: request))
        
    }
    
    
    
    
    
     func getCoinDetail(request: CoinDetailRequestParam) -> AnyPublisher<CoinDetailResponse, Error> {
        
    return cuckoo_manager.call(
    """
    getCoinDetail(request: CoinDetailRequestParam) -> AnyPublisher<CoinDetailResponse, Error>
    """,
            parameters: (request),
            escapingParameters: (request),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getCoinDetail(request: request))
        
    }
    
    
    
    
    
     func getMarketCharts(request: MarketChartRequestParam) -> AnyPublisher<MarketChartResponse, Error> {
        
    return cuckoo_manager.call(
    """
    getMarketCharts(request: MarketChartRequestParam) -> AnyPublisher<MarketChartResponse, Error>
    """,
            parameters: (request),
            escapingParameters: (request),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMarketCharts(request: request))
        
    }
    
    

     struct __StubbingProxy_MarketProvider: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func getMarkets<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.ProtocolStubFunction<(MarketRequestParam), AnyPublisher<[MarketResponse], Error>> where M1.MatchedType == MarketRequestParam {
            let matchers: [Cuckoo.ParameterMatcher<(MarketRequestParam)>] = [wrap(matchable: request) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockMarketProvider.self, method:
    """
    getMarkets(request: MarketRequestParam) -> AnyPublisher<[MarketResponse], Error>
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func getCoinDetail<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.ProtocolStubFunction<(CoinDetailRequestParam), AnyPublisher<CoinDetailResponse, Error>> where M1.MatchedType == CoinDetailRequestParam {
            let matchers: [Cuckoo.ParameterMatcher<(CoinDetailRequestParam)>] = [wrap(matchable: request) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockMarketProvider.self, method:
    """
    getCoinDetail(request: CoinDetailRequestParam) -> AnyPublisher<CoinDetailResponse, Error>
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func getMarketCharts<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.ProtocolStubFunction<(MarketChartRequestParam), AnyPublisher<MarketChartResponse, Error>> where M1.MatchedType == MarketChartRequestParam {
            let matchers: [Cuckoo.ParameterMatcher<(MarketChartRequestParam)>] = [wrap(matchable: request) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockMarketProvider.self, method:
    """
    getMarketCharts(request: MarketChartRequestParam) -> AnyPublisher<MarketChartResponse, Error>
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_MarketProvider: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func getMarkets<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.__DoNotUse<(MarketRequestParam), AnyPublisher<[MarketResponse], Error>> where M1.MatchedType == MarketRequestParam {
            let matchers: [Cuckoo.ParameterMatcher<(MarketRequestParam)>] = [wrap(matchable: request) { $0 }]
            return cuckoo_manager.verify(
    """
    getMarkets(request: MarketRequestParam) -> AnyPublisher<[MarketResponse], Error>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func getCoinDetail<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.__DoNotUse<(CoinDetailRequestParam), AnyPublisher<CoinDetailResponse, Error>> where M1.MatchedType == CoinDetailRequestParam {
            let matchers: [Cuckoo.ParameterMatcher<(CoinDetailRequestParam)>] = [wrap(matchable: request) { $0 }]
            return cuckoo_manager.verify(
    """
    getCoinDetail(request: CoinDetailRequestParam) -> AnyPublisher<CoinDetailResponse, Error>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func getMarketCharts<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.__DoNotUse<(MarketChartRequestParam), AnyPublisher<MarketChartResponse, Error>> where M1.MatchedType == MarketChartRequestParam {
            let matchers: [Cuckoo.ParameterMatcher<(MarketChartRequestParam)>] = [wrap(matchable: request) { $0 }]
            return cuckoo_manager.verify(
    """
    getMarketCharts(request: MarketChartRequestParam) -> AnyPublisher<MarketChartResponse, Error>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class MarketProviderStub: MarketProvider {
    

    

    
    
    
    
     func getMarkets(request: MarketRequestParam) -> AnyPublisher<[MarketResponse], Error>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<[MarketResponse], Error>).self)
    }
    
    
    
    
    
     func getCoinDetail(request: CoinDetailRequestParam) -> AnyPublisher<CoinDetailResponse, Error>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<CoinDetailResponse, Error>).self)
    }
    
    
    
    
    
     func getMarketCharts(request: MarketChartRequestParam) -> AnyPublisher<MarketChartResponse, Error>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<MarketChartResponse, Error>).self)
    }
    
    
}




