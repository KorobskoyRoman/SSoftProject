//
//  ViewController.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 28.02.2022.
//

import UIKit

final class SplashScreenViewController: UIViewController {
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var stackView: UIStackView!
    private let jsonService = JSONDecoderService()
    private let networkingService = NetworkingService()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        stackView.alpha = 0
    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.stackView.alpha = 1
        }, completion: nil)

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            backgroundQueue.async {
                self.networkingService.fetchData()
            }
            sleep(2)
            let tabBarVC = MainTabBarController()
            tabBarVC.modalPresentationStyle = .fullScreen
            tabBarVC.modalTransitionStyle = .flipHorizontal
            DispatchQueue.main.async {
                self.dismiss(animated: false) {
                    self.activityIndicator.stopAnimating()
                    self.present(tabBarVC, animated: true)
                }
            }
        }
    }

    private func setupView() {
        activityIndicator.startAnimating()
        navigationController?.navigationBar.isHidden = true
    }
}
