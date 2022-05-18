//
//  Network.swift
//  Assesment 2022
//
//  Created by RenhardJH on 24/03/22.
//

import Foundation
import Combine

final class Network {
    static var shared = Network()
    let timeout: Double = 60

    func connecting<T:Decodable>(urlRequest: RequestParam, model: T.Type) -> AnyPublisher<T, Error> {

        guard let url = URL(string: urlRequest.getURLParam()) else {
            return Fail(error: NSError(domain: "Invalid URL : \(urlRequest.getURLParam())", code: -10001, userInfo: nil)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = urlRequest.method.rawValue
        request.timeoutInterval = timeout
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        if let params = urlRequest.getBody(), let body = try? JSONSerialization.data(withJSONObject: params, options: [.fragmentsAllowed]) {
            request.httpBody = body
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { response in
                let decoder = JSONDecoder()
                guard let model = try? decoder.decode(T.self, from: response.data) else {
                    throw try decoder.decode(ResponseError.self, from: response.data)
                }
                return model
            }
            .eraseToAnyPublisher()
    }
}
