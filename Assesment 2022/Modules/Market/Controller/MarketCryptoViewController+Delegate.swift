//
//  MarketCryptoViewController+Delegate.swift
//  Assesment 2022
//
//  Created by RenhardJH on 24/03/22.
//

import UIKit

extension MarketCryptoViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.marketData?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MarketCryptoCell.reuseIdentifier(), for: indexPath) as? MarketCryptoCell else {
            return UITableViewCell()
        }

        if let market = viewModel.marketData?[indexPath.row] {
            cell.setData(market)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let itemCountTrigger = (viewModel.marketData?.count ?? 0) - 1
        if indexPath.row == itemCountTrigger {
            viewModel.getMarkets()
            loadingPagination?.startAnimating()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let market = viewModel.marketData?[indexPath.row],
           let id = market.id,
           let name = market.name {
            let coinDetailVC = CoinCryptoDetailViewController(id: id, name: name)
            navigationController?.pushViewController(coinDetailVC, animated: true)
        }
    }
}
