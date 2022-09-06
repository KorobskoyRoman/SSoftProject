//
//  HelpCategoriesConfigurator.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 09.08.2022.
//

import UIKit

class HelpCategoriesConfigurator: ConfiguratorProtocol {
    func configure(jsonService: JSONDecoderService? = nil,
                   networkManager: NetworkManager? = nil,
                   coordinator: AppCoordinator) -> UIViewController {
        let viewModel = HelpCategoriesViewModel()
        let viewController = HelpCategoriesViewController(viewModel: viewModel)
        viewModel.coordinator = coordinator
        return viewController
    }
}
