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
    func pop(coordinator: AppCoordinator?)
}

class HelpCategoriesPresenter: Presenter {
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
        categories[index]
    }

    private func fetchCategories() {
        let realm = try? Realm()
        self.categories = realm?.getCategories() ?? []
    }

    func pop(coordinator: AppCoordinator?) {
        guard let coordinator = coordinator else {
            return
        }
        coordinator.performTransition(with: .set(.charity))
    }
}
