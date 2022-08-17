//
//  CharityEventsRouter.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 16.08.2022.
//

import UIKit

final class CharityEventsRouter: CharityEventsRouterProtocol {
    weak var viewController: CharityEventsViewController?

    init(viewController: CharityEventsViewController) {
        self.viewController = viewController
    }

    func backButtonPressed() {
        let coordinator = AppCoordinator()
        coordinator.performTransition(with: .pop, nav: viewController?.navigationController)
    }

    func push(data: [RealmEvent], title: String) {
        let coordinator = AppCoordinator()
        coordinator.performTransition(with: .perform(.detailEvent),
                                      nav: viewController?.navigationController,
                                      title: title)
    }
}
