//
//  MarketCryptoCell.swift
//  Assesment 2022
//
//  Created by RenhardJH on 24/03/22.
//

import UIKit
import DSFSparkline
import SDWebImage

class MarketCryptoCell: UITableViewCell {
    @IBOutlet weak var lbTicker: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbPriceChanges: UILabel!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var graphView: DSFSparklineLineGraphView!

    var spark1ds = DSFSparkline.DataSource(windowSize: 200, range: -100000 ... 100000)

    func setData(_ data: MarketResponse) {

        lbTicker.text = data.symbol?.uppercased()
        lbName.text = data.name
        lbPrice.text = data.currentPrice?.toCurrency()

        let priceChangePercentage24H = data.priceChangePercentage24H ?? 0
        if priceChangePercentage24H >= 0 {
            graphView.graphColor = .systemGreen
            lbPriceChanges.textColor = .systemGreen
            lbPriceChanges.text = String(format: "%.2f", priceChangePercentage24H) + "%"
        } else {
            graphView.graphColor = .systemRed
            lbPriceChanges.textColor = .systemRed
            lbPriceChanges.text = String(format: "%.2f", priceChangePercentage24H) + "%"
        }
        graphView.lineShading = false
        graphView.showZeroLine = false

        ivIcon.sd_setImage(with: URL(string: data.image ?? ""))

        spark1ds.reset()
        spark1ds = DSFSparkline.DataSource(windowSize: 50, range: CGFloat(data.sparklineIn7D?.price?.min() ?? 0)
                                           ... CGFloat(data.sparklineIn7D?.price?.max() ?? 0))
        graphView.dataSource = spark1ds
        data.sparklineIn7D?.price?.forEach { [weak self] price in
            _ = self?.spark1ds.push(value: CGFloat(price))
        }
    }
}
