//
//  CharityEventsProtocols.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 16.08.2022.
//

import UIKit

protocol CharityEventsConfiguratorProtocol: AnyObject {
    func configure(with viewController: CharityEventsViewController)
}

protocol CharityEventsViewProtocol: AnyObject {
    func segmentedControlChangeState(_ sender: UISegmentedControl)
    func setupView()
    func setupCollectionView()
    func backButtonPressed()
    func createCompositialLayout() -> UICollectionViewLayout
    func createMainSection() -> NSCollectionLayoutSection
    func createDiffableDataSource() -> UICollectionViewDiffableDataSource<Section, RealmEvent>
    func applySnapshot(animatingDifferences: Bool)
    func fetchEvents(for name: String)
    func getSegmentData(_ index: Int, _ catName: String)
}

protocol CharityEventsPresenterProtocol: AnyObject {
    var reload: (() -> Void)? { get set }
    var events: [RealmEvent] { get set }
    var filteredEvents: [RealmEvent] { get set }
    func backButtonPressed()
    func push(data: [RealmEvent], row: Int)
    func getSegmentData(_ index: Int, _ catName: String)
    func fetchEvents(for name: String)
}

protocol CharityEventsInteractorProtocol: AnyObject {
    var events: [RealmEvent] { get set }
    func fetchEvents()
}

protocol CharityEventsRouterProtocol: AnyObject {
    func backButtonPressed()
    func push(data: [RealmEvent], row: Int)
}
