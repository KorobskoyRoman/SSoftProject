//
//  CharityEventsConfigurator.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 15.08.2022.
//

import Foundation

final class CharityEventsVCConfigurator: CharityEventsConfiguratorProtocol {
    func configure(with viewController: CharityEventsViewController, coordinator: AppCoordinator) {
        let presenter = CharityEventsPresenter()
        let interactor = CharityEventsInteractor(presenter: presenter)
        let router = CharityEventsRouter(viewController: viewController)

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.view = viewController
        presenter.router = router
        router.coordinator = coordinator
    }
}
