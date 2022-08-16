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
        let events = realm?.getEvents() ?? []
        presenter?.events = events
    }
}
