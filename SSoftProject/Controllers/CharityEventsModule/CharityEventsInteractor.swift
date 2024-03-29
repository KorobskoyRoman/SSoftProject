//
//  CharityEventsInteractor.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 16.08.2022.
//

import RealmSwift

final class CharityEventsInteractor: CharityEventsInteractorProtocol {
    var events: [RealmEvent] = []
    var presenter: CharityEventsPresenterProtocol?
    let realm = try? Realm()

    required init(presenter: CharityEventsPresenterProtocol) {
        self.presenter = presenter
    }

    func fetchEvents() {
//        backgroundQueue.asyncAfter(deadline: .now() + 2) { [weak self] in
//            guard let self = self else { return }
            self.events = self.realm?.getEvents() ?? []
//        }
        presenter?.didReceiveEvents(events)
    }

    func getSegmentData(_ index: Int,
                        _ catName: String) {
        switch index {
        case 0:
            presenter?.filteredEvents = self.events
                .filter { $0.category == catName }
                .filter { !$0.isDone }
        case 1:
            presenter?.filteredEvents = events
                .filter { $0.category == catName }
                .filter { $0.isDone }
        default:
            presenter?.filteredEvents = self.events
                .filter { $0.category == catName }
                .filter { !$0.isDone }
        }
    }
}
