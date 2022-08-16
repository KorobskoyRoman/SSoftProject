//
//  CharityEventsRouter.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 16.08.2022.
//

import Foundation

final class CharityEventsRouter: CharityEventsRouterProtocol {
    weak var viewController: CharityEventsViewController?

    init(viewController: CharityEventsViewController) {
        self.viewController = viewController
    }

    func backButtonPressed() {
        print(#function)
    }

    func push() {
        print(#function)
    }
}
