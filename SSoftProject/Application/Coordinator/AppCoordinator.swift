//
//  AppCoordinator.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 08.08.2022.
//

import UIKit

final class AppCoordinator: Coordinator {
    var jsonService = JSONDecoderService()
    var networkManager = NetworkManager()
    var rootViewController: UINavigationController?

    func start(window: UIWindow?) {
        rootViewController = UINavigationController(rootViewController: getViewControllerByType(type: .splash))
        guard let controller = rootViewController else { return }
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }

    func performTransition(with type: Transition,
                           nav: UINavigationController? = nil,
                           title: String? = "") {
        switch type {
        case .set(let viewController):
            let controller = getViewControllerByType(type: viewController)
            rootViewController?.setViewControllers([controller], animated: true)
        case .pop:
            nav?.popViewController(animated: true)
        case .perform(let viewController):
            let controller = getViewControllerByType(type: viewController)
            controller.navigationItem.title = title
            nav?.pushViewController(controller, animated: true)
        }
    }

    func setupTabbar(_ tabbarVC: UITabBarController) {
        let newsVC = UIViewController()
        newsVC.view.backgroundColor = .yellow
        newsVC.tabBarItem.title = TabBarConstants.newsVCTitle
        newsVC.tabBarItem.image = TabBarConstants.newsVCImage

        let searchVC = UIViewController()
        searchVC.view.backgroundColor = .systemRed
        searchVC.tabBarItem.title = TabBarConstants.searchVCTitle
        searchVC.tabBarItem.image = TabBarConstants.searchVCImage

        let helpVC = getViewControllerByType(type: .help) // heart button
        let helpVCNav = UINavigationController(rootViewController: helpVC)
        helpVCNav.navigationBar.standardAppearance = configureNavBarAppearence()
        helpVCNav.navigationBar.compactAppearance = configureNavBarAppearence()
        helpVCNav.navigationBar.scrollEdgeAppearance = configureNavBarAppearence()
        helpVCNav.tabBarItem.title = TabBarConstants.helpVCTitle

        let historyVC = UIViewController()
        historyVC.view.backgroundColor = .systemFill
        historyVC.tabBarItem.title = TabBarConstants.historyVCTitle
        historyVC.tabBarItem.image = TabBarConstants.historyVCImage

        let profileVC = UIViewController()
        profileVC.view.backgroundColor = .charcoalGrey
        profileVC.tabBarItem.title = TabBarConstants.profileVCTitle
        profileVC.tabBarItem.image = TabBarConstants.profileVCImage

        tabbarVC.tabBar.tintColor = .leaf
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.leaf], for: .selected)

        tabbarVC.viewControllers = [newsVC, searchVC, helpVCNav, historyVC, profileVC]
        tabbarVC.selectedViewController = tabbarVC.viewControllers?[TabBarConstants.currentIndexOfMiddleButton]
        tabbarVC.selectedIndex = TabBarConstants.currentIndexOfMiddleButton
    }

    private func getViewControllerByType(type: ViewControllers) -> UIViewController {
        var viewController: UIViewController
        switch type {
        case .tabbar:
            let config = TabBarConfigurator()
            viewController = config.configure(coordinator: self)
            return viewController
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

extension AppCoordinator {
    private func configureNavBarAppearence() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .leaf
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.textStyle3]

        let backButtonAppearance = UIBarButtonItemAppearance(style: .plain)
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]

        appearance.backButtonAppearance = backButtonAppearance
        UINavigationBar.appearance().tintColor = .white

        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance

        return appearance
    }
}
