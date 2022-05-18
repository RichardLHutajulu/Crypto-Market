//
//  UITableViewCell+Ext.swift
//  Assesment 2022
//
//  Created by RenhardJH on 24/03/22.
//

import UIKit

extension UITableViewCell {

    class func reuseIdentifier() -> String {
        return String(describing: self)
    }

    class func nib() -> UINib? {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
