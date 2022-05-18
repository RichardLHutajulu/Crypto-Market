//
//  BaseViewController.swift
//  Assesment 2022
//
//  Created by RenhardJH on 24/03/22.
//

import UIKit

class BaseViewController: UIViewController {
    private lazy var loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.hidesWhenStopped = true
        loading.center = view.center
        view.addSubview(loading)
        return loading
    }()

    func addNavBarTitleLeft(title: String, selector: Selector = #selector(popViewController)) {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "ic_back")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .gray
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.frame.size = CGSize(width: 50, height: 44)
        button.contentHorizontalAlignment = .left

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .gray
        titleLabel.font = Fonts.bold.custom(size: 20)

        let stackView = UIStackView(arrangedSubviews: [button, titleLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: stackView)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        stackView.addConstraints([NSLayoutConstraint(item: button,
                                                    attribute: .width,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1, constant: 30)])

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: Fonts.bold.custom(size: 16),
            NSAttributedString.Key.foregroundColor: UIColor.gray
        ]
    }

    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }

    func showLoading(_ show: Bool = true) {
        if show {
            loadingView.startAnimating()
        } else {
            loadingView.stopAnimating()
        }
    }
}

extension BaseViewController: ViewModelPresenter {

    func showLoadingView(_ show: Bool) {
        showLoading(show)
    }
}
