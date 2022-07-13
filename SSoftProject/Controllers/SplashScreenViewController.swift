//
//  ViewController.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 28.02.2022.
//

import UIKit

class SplashScreenViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var stackView: UIStackView!

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

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let tabBarVC = MainTabBarController()
            tabBarVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(tabBarVC, animated: true)
        }
    }

    private func setupView() {
        activityIndicator.startAnimating()
        navigationController?.navigationBar.isHidden = true
    }
}
