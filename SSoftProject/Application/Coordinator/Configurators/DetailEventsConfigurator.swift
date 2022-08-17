//
//  DetailEventsConfigurator.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 09.08.2022.
//

import UIKit

class DetailEventsConfigurator {
    func configure(jsonService: JSONDecoderService? = nil,
                   networkManager: NetworkManager? = nil,
                   coordinator: AppCoordinator?) -> UIViewController {
        let viewController = DetailEventViewController(coordinator: coordinator)
//        viewController.coordinator = coordinator
        return viewController
    }
}
