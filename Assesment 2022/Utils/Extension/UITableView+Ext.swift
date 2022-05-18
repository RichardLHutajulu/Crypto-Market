//
//  UITableView+Ext.swift
//  Assesment 2022
//
//  Created by RenhardJH on 26/04/22.
//

import UIKit

extension UITableView {

    func addFooterLoadingView() {
        let loading = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        loading.hidesWhenStopped = true
        self.tableFooterView = loading
        loading.stopAnimating()
    }

    func deselectAllRows(animated: Bool) {
        guard let selectedRows = indexPathsForSelectedRows else { return }
        for indexPath in selectedRows { deselectRow(at: indexPath, animated: animated) }
    }
}
