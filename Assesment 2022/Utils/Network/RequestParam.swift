//
//  URLParam.swift
//  Assesment 2022
//
//  Created by RenhardJH on 24/03/22.
//

import Foundation

protocol RequestParam {
    var url: String { get set }
    var method: URLMethod { get set }

    func getURLParam() -> String
    func getBody() -> [String : Any]?
}

enum URLMethod: String {
    case GET
    case POST
}
