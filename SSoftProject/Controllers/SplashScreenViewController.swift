//
//  ViewController.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 28.02.2022.
//

import UIKit

final class SplashScreenViewController: UIViewController {
    weak var coordinator: AppCoordinator?
    var jsonService: JSONDecoderService?
    var networkManager: NetworkManager?
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var infoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        print("loaded")
    }

    override func viewWillAppear(_ animated: Bool) {
        stackView.alpha = 0
    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.stackView.alpha = 1
        }, completion: nil)

        DispatchQueue.main.async { [weak self] in
            autoreleasepool {
                guard let self = self else { return }
                backgroundQueue.sync {
                    self.networkManager?.getCategories { result in
                        switch result {
                        case .success(let data):
                            RealmService.shared.getCategoriesIntoRealmWithNetwork(from: data)
                        case .failure(let error):
                            print(error)
                            self.jsonService?.decodeToDataBase()
                        }
                    }
                    self.networkManager?.getEvents { result in
                        switch result {
                        case .success(let data):
                            RealmService.shared.getEventsIntoRealmWithNetwork(from: data)
                        case .failure(let error):
                            print(error)
                            self.jsonService?.decodeToDataBase()
                        }
                    }
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.activityIndicator.stopAnimating()
                    self.coordinator?.performTransition(with: .set(.tabbar))
                }
            }
        }
    }

    private func setupView() {
        activityIndicator.startAnimating()
        navigationController?.navigationBar.isHidden = true
    }
}

extension SplashScreenViewController: Storyboarded {}
