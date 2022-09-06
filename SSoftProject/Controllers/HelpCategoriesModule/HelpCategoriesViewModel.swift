//
//  HelpCategoriesPresenter.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 12.08.2022.
//

import Foundation
import RealmSwift
import RxSwift
import RxRelay

protocol HelpViewModelProtocol {
    var categories: BehaviorRelay<[RealmCategories]> { get }
    func push(nav: UINavigationController,
              title: String?)
}

class HelpCategoriesViewModel: HelpViewModelProtocol {
    weak var coordinator: AppCoordinator?
    var categories: BehaviorRelay<[RealmCategories]>

    init() {
        let realm = try? Realm()
        let response = BehaviorRelay<[RealmCategories]>(value: realm?.getCategories() ?? [])
        self.categories = response
    }

    func push(nav: UINavigationController,
              title: String?) {
        coordinator?.rootViewController = nav
        coordinator?.performTransition(with: .perform(.charity), nav: nav, title: title)
    }
}
