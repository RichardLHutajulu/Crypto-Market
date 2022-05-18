//
//  Double+Ext.swift
//  Assesment 2022
//
//  Created by RenhardJH on 26/04/22.
//

import Foundation
import Localize_Swift

extension Double {
    func toCurrency() -> String {
        if Localize.currentLanguage() == Language.id.rawValue {
            let formatter = NumberFormatter()
            formatter.locale = Locale.current
            formatter.numberStyle = .currency
            formatter.currencySymbol = "$".localized()
            formatter.maximumFractionDigits = 0
            let text = "\((formatter.string(from: self as NSNumber) ?? "").replacingOccurrences(of: ",", with: "."))"
            return text
        } else {
            let formatter = NumberFormatter()
            formatter.locale = Locale.current
            formatter.numberStyle = .currency
            formatter.currencySymbol = "$".localized()
            formatter.maximumFractionDigits = 2
            let text = "\((formatter.string(from: self as NSNumber) ?? ""))"
            return text
        }
    }
}
