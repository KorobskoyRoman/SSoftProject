//
//  CoordinatorProtocol.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 08.08.2022.
//

import UIKit

protocol Coordinator {
    var rootViewController: UINavigationController? { get set }
    var jsonService: JSONDecoderService { get set }
    var networkManager: NetworkManager { get set }

    func start(window: UIWindow?)
    func performTransition(with type: Transition)
}

enum Transition {
    case set(ViewControllers)
    case pop
}

enum ViewControllers {
    case tabbar
    case splash
    case help
    case charity
    case detailEvent

    var viewController: UIViewController {
        switch self {
        case .tabbar:
            return MainTabBarController()
        case .splash:
            return SplashScreenViewController.instantiate()
        case .help:
            return HelpCategoriesViewController()
        case .charity:
            return CharityEventsViewController()
        case .detailEvent:
            return DetailEventViewController()
        }
    }
}
