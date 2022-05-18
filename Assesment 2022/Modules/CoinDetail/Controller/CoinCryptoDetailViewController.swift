//
//  CoinCryptoDetailViewController.swift
//  Assesment 2022
//
//  Created by RenhardJH on 26/04/22.
//

import UIKit
import DSFSparkline

class CoinCryptoDetailViewController: BaseViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lbTicker: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbPriceChangePercent: UILabel!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var graphView: DSFSparklineLineGraphView!
    @IBOutlet weak var svTimeChart: UISegmentedControl!
    @IBOutlet weak var lbMarketCapTitle: UILabel!
    @IBOutlet weak var lbMarketCap: UILabel!
    @IBOutlet weak var lbMarketRankTitle: UILabel!
    @IBOutlet weak var lbMarketRank: UILabel!
    @IBOutlet weak var lbDescriptionTitle: UILabel!
    @IBOutlet weak var lbDescription: UILabel!

    private lazy var viewModel: CoinCryptoDetailViewModel = {
        let vm = CoinCryptoDetailViewModel(service: MarketServices())
        vm.presenter = self
        return vm
    }()

    convenience init(id: String, name: String) {
        self.init(nibName: "CoinCryptoDetailViewController", bundle: nil)
        viewModel.request.id = id
        viewModel.requestChart.id = id
        viewModel.coinName = name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarTitleLeft(title: viewModel.coinName)
        setupView()
        setLocalization()
        bindViewModel()

        viewModel.getCoinDetail()
    }

    private func setupView() {
        scrollView.isHidden = true
        svTimeChart.addTarget(self, action: #selector(timeChartControlValueChanged(_:)), for: .valueChanged)
    }

    private func setLocalization() {
        lbMarketCapTitle.text = "market_cap".localized()
        lbMarketRankTitle.text = "market_rank".localized()
        lbDescriptionTitle.text = "description".localized()
        svTimeChart.setTitle("1d".localized(), forSegmentAt: 0)
        svTimeChart.setTitle("1w".localized(), forSegmentAt: 1)
        svTimeChart.setTitle("1m".localized(), forSegmentAt: 2)
        svTimeChart.setTitle("1y".localized(), forSegmentAt: 3)
    }

    private func bindViewModel() {
        viewModel.$coinData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                if data != nil {
                    self?.fetchCoinData(data)
                    self?.scrollView.isHidden = false
                    self?.viewModel.getMarketCharts()
                }
            }
            .store(in: &viewModel.subscriptions)

        viewModel.$chartData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                if data != nil {
                    self?.fetchChartData(data)
                }
            }
            .store(in: &viewModel.subscriptions)
    }

    @objc func timeChartControlValueChanged(_ sender: UISegmentedControl) {
        let localize = Session.shared.getLocalize()
        viewModel.priceChangePercentage = viewModel.coinData?.marketData?.priceChangePercentage24HInCurrency?[(localize == .id ? CurrencyType.idr : CurrencyType.usd).rawValue] ?? 0
        switch sender.selectedSegmentIndex {
        case 0:
            viewModel.priceChangePercentage = viewModel.coinData?.marketData?.priceChangePercentage24H ?? 0
            viewModel.getMarketCharts(days: .day)
        case 1:
            viewModel.priceChangePercentage = viewModel.coinData?.marketData?.priceChangePercentage7D ?? 0
            viewModel.getMarketCharts(days: .week)
        case 2:
            viewModel.priceChangePercentage = viewModel.coinData?.marketData?.priceChangePercentage30D ?? 0
            viewModel.getMarketCharts(days: .month)
        case 3:
            viewModel.priceChangePercentage = viewModel.coinData?.marketData?.priceChangePercentage1Y ?? 0
            viewModel.getMarketCharts(days: .year)
        default:
            break
        }
        if viewModel.priceChangePercentage >= 0 {
            lbPriceChangePercent.textColor = .systemGreen
            lbPriceChangePercent.text = String(format: "%.2f", viewModel.priceChangePercentage) + "%"
        } else {
            lbPriceChangePercent.textColor = .systemRed
            lbPriceChangePercent.text = String(format: "%.2f", viewModel.priceChangePercentage) + "%"
        }
    }

    private func fetchCoinData(_ data: CoinDetailResponse?) {
        lbTicker.text = data?.symbol?.uppercased()
        let localize = Session.shared.getLocalize()
        lbPrice.text = data?.marketData?.currentPrice?[localize == .id ? CurrencyType.idr.rawValue : CurrencyType.usd.rawValue]?.toCurrency()
        viewModel.priceChangePercentage = data?.marketData?.priceChangePercentage24HInCurrency?[(localize == .id ? CurrencyType.idr : CurrencyType.usd).rawValue] ?? 0
        if viewModel.priceChangePercentage >= 0 {
            lbPriceChangePercent.textColor = .systemGreen
            lbPriceChangePercent.text = String(format: "%.2f", viewModel.priceChangePercentage) + "%"
        } else {
            lbPriceChangePercent.textColor = .systemRed
            lbPriceChangePercent.text = String(format: "%.2f", viewModel.priceChangePercentage) + "%"
        }

        lbMarketCap.text = data?.marketData?.marketCap?[localize == .id ? CurrencyType.idr.rawValue : CurrencyType.usd.rawValue]?.toCurrency()
        lbMarketRank.text = "\(data?.marketCapRank ?? 0)"
        lbDescription.attributedText = (localize == .id ? data?.description?.id ?? data?.description?.en : data?.description?.en)?.convertHtmlToAttributedStringWithCSS(font: Fonts.regular.custom(size: 16), csscolor: "gray", lineheight: 5, csstextalign: "justify")

        ivIcon.sd_setImage(with: URL(string: data?.image?.large ?? ""))
    }

    private func fetchChartData(_ data: MarketChartResponse?) {
        if viewModel.priceChangePercentage >= 0 {
            graphView.graphColor = .systemGreen
        } else {
            graphView.graphColor = .systemRed
        }
        viewModel.sparkds.reset()
        viewModel.sparkds = DSFSparkline.DataSource(windowSize: 50, range: CGFloat(data?.prices?.compactMap({ $0.last }).min() ?? 0) ... CGFloat(data?.prices?.compactMap({ $0.last }).max() ?? 0))
        graphView.dataSource = viewModel.sparkds
        data?.prices?.compactMap({ $0.last }).forEach { [weak self] price in
            _ = self?.viewModel.sparkds.push(value: CGFloat(price))
        }
    }

    func onNetworkError(message: String) {
        let alert = UIAlertController(title: "oops".localized(), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "reload".localized(), style: .default, handler: { [weak self] _ in
            self?.viewModel.getCoinDetail()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
