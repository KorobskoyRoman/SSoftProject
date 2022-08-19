//
//  CharityEventsRouter.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 16.08.2022.
//

import UIKit

final class CharityEventsRouter: CharityEventsRouterProtocol {
    weak var viewController: CharityEventsViewController?
    weak var coordinator: AppCoordinator?

    init(viewController: CharityEventsViewController) {
        self.viewController = viewController
    }

    func backButtonPressed() {
        coordinator?.performTransition(with: .pop, nav: viewController?.navigationController)
    }

    func push(data: [RealmEvent], title: String) {
        coordinator?.performTransition(with: .perform(.detailEvent),
                                      nav: viewController?.navigationController,
                                      title: title)
    }
}
