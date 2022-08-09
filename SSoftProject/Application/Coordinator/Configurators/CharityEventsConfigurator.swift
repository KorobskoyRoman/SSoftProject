//
//  CharityEventsConfigurator.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 09.08.2022.
//

import UIKit

class CharityEventsConfigurator: ConfiguratorProtocol {
    func configure(jsonService: JSONDecoderService? = nil,
                   networkManager: NetworkManager? = nil,
                   coordinator: AppCoordinator) -> UIViewController {
        let viewController = CharityEventsViewController()
        viewController.coordinator = coordinator
        return viewController
    }
}
