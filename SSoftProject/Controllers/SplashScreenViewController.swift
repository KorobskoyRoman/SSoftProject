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

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            let tabBarVC = MainTabBarController()
            tabBarVC.modalPresentationStyle = .fullScreen
            tabBarVC.modalTransitionStyle = .flipHorizontal
            self.dismiss(animated: false)
            self.present(tabBarVC, animated: true)
        }
    }

    private func setupView() {
        activityIndicator.startAnimating()
        navigationController?.navigationBar.isHidden = true
    }
}
