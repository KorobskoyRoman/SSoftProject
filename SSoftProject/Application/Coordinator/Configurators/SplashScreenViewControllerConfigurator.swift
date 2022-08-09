//
//  SplashScreenViewControllerConfigurator.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 08.08.2022.
//

import UIKit

class SplashConfigurator: ConfiguratorProtocol {
    func configure(jsonService: JSONDecoderService?,
                   networkManager: NetworkManager?,
                   coordinator: AppCoordinator) -> UIViewController {
        guard let jsonService = jsonService,
              let networkManager = networkManager
        else {
            return UIViewController()
        }
        let viewController = SplashScreenViewController.instantiate()
        viewController.jsonService = jsonService
        viewController.networkManager = networkManager
        viewController.coordinator = coordinator
        return viewController
    }
}
