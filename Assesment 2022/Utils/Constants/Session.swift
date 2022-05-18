//
//  Session.swift
//  Assesment 2022
//
//  Created by RenhardJH on 26/04/22.
//

import Foundation

class Session {

    static let shared = Session()

    private let userDefaults = UserDefaults(suiteName: "group.com.renhard.Assesment-2022")
    private let kcCurrentLanguage = "LCLCurrentLanguageKey"

    func setLocalize(_ locale: String) {
        userDefaults?.setValue(locale, forKey: kcCurrentLanguage)
    }

    func getLocalize() -> Language {
        return Language(rawValue: userDefaults?.string(forKey: kcCurrentLanguage) ?? Language.en.rawValue) ?? .en
    }
}
