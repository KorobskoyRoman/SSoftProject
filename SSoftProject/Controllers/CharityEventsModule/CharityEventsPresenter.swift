//
//  CharityEventsPresenter.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 15.08.2022.
//

import UIKit

final class CharityEventsPresenter: CharityEventsPresenterProtocol {
    weak var view: CharityEventsViewProtocol?
    var interactor: CharityEventsInteractorProtocol?
    var router: CharityEventsRouterProtocol?
    var reload: (() -> Void)?
    var events = [RealmEvent]()
    var filteredEvents = [RealmEvent]()

    func backButtonPressed() {
        router?.backButtonPressed()
    }

    func push(row: Int, title: String) {
        let event = filteredEvents
            .filter { $0.id == row }
        router?.push(data: event, title: title)
    }

    func getSegmentData(_ index: Int,
                        _ catName: String) {
        interactor?.getSegmentData(index, catName)
        reload?()
    }

    func fetchEvents(for name: String) {
        view?.showLoading()
        interactor?.fetchEvents()
        filteredEvents = self.events
            .filter { $0.category == name }
            .filter { !$0.isDone }
        view?.hideLoading()
        reload?()
    }

    func didReceiveEvents(_ events: [RealmEvent]) {
        self.events = events
    }
}
