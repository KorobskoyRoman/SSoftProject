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
        viewController?.navigationController?.popViewController(animated: true)
    }

    func push(data: [RealmEvent], row: Int) {
        let detailsVC = DetailEventViewController()
        detailsVC.eventInfo = data
            .filter { $0.id == row }
        viewController?.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
