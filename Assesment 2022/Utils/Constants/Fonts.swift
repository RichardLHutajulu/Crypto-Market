//
//  Fonts.swift
//  Assesment 2022
//
//  Created by RenhardJH on 26/04/22.
//

import UIKit

enum Fonts: String {
    case bold     = "SourceSansPro-Bold"
    case light    = "SourceSansPro-Light"
    case regular  = "SourceSansPro-Regular"
    case semiBold = "SourceSansPro-SemiBold"
    case semiBoldItalic = "SourceSansPro-SemiBoldItalic"
    case boldItalic = "SourceSansPro-BoldItalic"
    case italic = "SourceSansPro-Italic"

    func custom(size: CGFloat) -> UIFont {
        switch self {
        case .bold    : return UIFont(name: self.rawValue, size: size)!
        case .light   : return UIFont(name: self.rawValue, size: size)!
        case .regular : return UIFont(name: self.rawValue, size: size)!
        case .semiBold : return UIFont(name: self.rawValue, size: size)!
        default : return UIFont(name: self.rawValue, size: size)!
        }
    }
}
