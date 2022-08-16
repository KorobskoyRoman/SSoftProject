//
//  CharityEventsPresenter.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 15.08.2022.
//

import Foundation

final class CharityEventsPresenter: CharityEventsPresenterProtocol {
    var interactor: CharityEventsInteractorProtocol?
    var router: CharityEventsRouterProtocol?
    var reload: (() -> Void)?
    var events = [RealmEvent]()
    var filteredEvents = [RealmEvent]()

    func backButtonPressed() {
        router?.backButtonPressed()
    }

    func push(data: [RealmEvent], row: Int) {
        router?.push(data: data, row: row)
    }

    func getSegmentData(_ index: Int,
                        _ catName: String) {
        switch index {
        case 0:
            self.filteredEvents = self.events
                .filter { $0.category == catName }
                .filter { !$0.isDone }
        case 1:
            filteredEvents = events
                .filter { $0.category == catName }
                .filter { $0.isDone }
        default:
            self.filteredEvents = self.events
                .filter { $0.category == catName }
                .filter { !$0.isDone }
        }
        reload?()
    }

    func fetchEvents(for name: String) {
        interactor?.fetchEvents()
        filteredEvents = events.filter { $0.category == name }.filter { !$0.isDone }
        reload?()
    }
}
