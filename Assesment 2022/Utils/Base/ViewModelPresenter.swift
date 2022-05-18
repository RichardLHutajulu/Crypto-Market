//
//  ViewModelPresenter.swift
//  Assesment 2022
//
//  Created by RenhardJH on 31/03/22.
//

import Foundation

@objc protocol ViewModelPresenter {
    func showLoadingView(_ show: Bool)
    @objc optional func onNetworkError(message: String)
}
