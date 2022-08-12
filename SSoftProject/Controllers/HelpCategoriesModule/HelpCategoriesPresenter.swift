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
}

class HelpCategoriesPresenter: Presenter {
    var categories = [RealmCategories]()
    var reload: (() -> Void)?
    var categoriesCount: Int {
        categories.count
    }
    private let decodeService = JSONDecoderService()
//    private let realm = try? Realm()

    func getData() {
        self.fetchCategories()
        self.reload?()
    }

    func category(at index: Int) -> RealmCategories {
        categories[index]
    }

    private func fetchCategories() {
//        backgroundQueue.async { [weak self] in
//            guard let self = self else { return }
            let realm = try? Realm()
            self.categories = realm?.getCategories() ?? []
//        }
    }
}
