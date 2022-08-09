//
//  AppCoordinator.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 08.08.2022.
//

import UIKit

class AppCoordinator: Coordinator {
    var jsonService = JSONDecoderService()
    var networkManager = NetworkManager()
    var rootViewController: UINavigationController?

    func start(window: UIWindow?) {
        rootViewController = UINavigationController(rootViewController: getViewControllerByType(type: .splash))
        guard let controller = rootViewController else { return }
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }

    func perfornTransition(with type: Transition) {
        switch type {
        case .set(let viewController):
            let controller = getViewControllerByType(type: viewController)
            rootViewController?.setViewControllers([controller], animated: true)
        case .pop:
            rootViewController?.popViewController(animated: true)
        }
    }

    func switchToTabbar(mainVC: UIViewController,
                        to navVC: UINavigationController) -> UINavigationController {
        rootViewController = navVC
        navVC.setViewControllers([mainVC], animated: true)
        guard let controller = rootViewController else {
            return UINavigationController(rootViewController: mainVC)
        }
        return controller
    }

    private func getViewControllerByType(type: ViewControllers) -> UIViewController {
        var viewController: UIViewController
        switch type {
        case .tabbar:
            let config = TabBarConfigurator()
            viewController = config.configure(coordinator: self)
            return MainTabBarController()
        case .splash:
            let config = SplashConfigurator()
            viewController = config.configure(jsonService: jsonService,
                                              networkManager: networkManager,
                                              coordinator: self)
            return viewController
        case .help:
            let config = HelpCategoriesConfigurator()
            viewController = config.configure(coordinator: self)
            return viewController
        case .charity:
            let config = CharityEventsConfigurator()
            viewController = config.configure(coordinator: self)
            return viewController
        case .detailEvent:
            let config = DetailEventsConfigurator()
            viewController = config.configure(coordinator: self)
            return viewController
        }
    }
}
