//
//  HelpCategoriesPresenter.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 12.08.2022.
//

import Foundation
import RealmSwift

protocol Presenter {
    var reload: (() -> Void)? { get set }

    func getData()
    func push(nav: UINavigationController,
              title: String?)
}

class HelpCategoriesPresenter: Presenter {
    weak var coordinator: AppCoordinator?
    var categories = [RealmCategories]()
    var reload: (() -> Void)?
    var categoriesCount: Int {
        categories.count
    }
    private let decodeService = JSONDecoderService()

    func getData() {
        self.fetchCategories()
        self.reload?()
    }

    func category(at index: Int) -> RealmCategories {
        categories[safe: index] ?? RealmCategories()
    }

    private func fetchCategories() {
        let realm = try? Realm()
        self.categories = realm?.getCategories() ?? []
    }

    func push(nav: UINavigationController,
              title: String?) {
        coordinator?.rootViewController = nav
        coordinator?.performTransition(with: .perform(.charity), nav: nav, title: title)
    }
}
