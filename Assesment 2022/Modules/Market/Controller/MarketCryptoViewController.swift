//
//  ViewController.swift
//  Assesment 2022
//
//  Created by RenhardJH on 24/03/22.
//

import UIKit
import Localize_Swift

class MarketCryptoViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!

    lazy var loadingPagination: UIActivityIndicatorView? = {
        return tableView.tableFooterView as? UIActivityIndicatorView
    }()

    internal lazy var viewModel: MarketCryptoViewModel = {
        let vm = MarketCryptoViewModel(service: MarketServices())
        vm.presenter = self
        return vm
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupView()
        bindViewModel()

        viewModel.getMarkets(reset: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.deselectAllRows(animated: false)
    }

    private func setupNavbar() {
        let swLocalize = UISwitch()
        swLocalize.setOn(Session.shared.getLocalize() == .id, animated: false)
        swLocalize.onTintColor = .orange
        swLocalize.tintColor = .orange
        swLocalize.layer.cornerRadius = swLocalize.frame.height / 2.0
        swLocalize.backgroundColor = .orange
        swLocalize.clipsToBounds = true

        swLocalize.addTarget(self, action: #selector(didChangeLanguage), for:UIControl.Event.valueChanged)

        let titleLabel = UILabel()
        titleLabel.font = Fonts.regular.custom(size: 16)
        titleLabel.text = "\(Session.shared.getLocalize())".uppercased()
        let stackView = UIStackView(arrangedSubviews: [swLocalize, titleLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: stackView)
    }

    private func setupView() {
        title = "Marketplace"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50

        tableView.addFooterLoadingView()
        tableView.register(MarketCryptoCell.nib(), forCellReuseIdentifier: MarketCryptoCell.reuseIdentifier())
    }

    private func bindViewModel() {
        viewModel.$marketData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                if data != nil {
                    self?.tableView.reloadData()
                    self?.loadingPagination?.stopAnimating()
                }
            }
            .store(in: &viewModel.subscriptions)
    }

    func onNetworkError(message: String) {
        let alert = UIAlertController(title: "oops".localized(), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "reload".localized(), style: .default, handler: { [weak self] _ in
            self?.viewModel.getMarkets()
        }))
        self.present(alert, animated: true, completion: nil)
    }

    @objc private func didChangeLanguage(sw: UISwitch) {
        let language = sw.isOn ? Language.id.rawValue : Language.en.rawValue
        Localize.setCurrentLanguage(language)
        Session.shared.setLocalize(language)
        let titleLabel = (sw.superview as? UIStackView)?.subviews.last as? UILabel
        titleLabel?.text = "\(Session.shared.getLocalize())".uppercased()
        viewModel.getMarkets(reset: true)
    }
}
