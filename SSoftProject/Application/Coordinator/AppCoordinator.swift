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
//        rootViewController = UITabBarController()
        guard let controller = rootViewController else { return }
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }

    func performTransition(with type: Transition) {
        switch type {
        case .set(let viewController):
            let controller = getViewControllerByType(type: viewController)
            rootViewController?.setViewControllers([controller], animated: true)
        case .pop:
            rootViewController?.popViewController(animated: true)
        }
    }

//    func showMainFlow() {
//        let tabCoordinator = TabBarCoordinator(rootViewController ?? UINavigationController())
//        tabCoordinator.start()
//    }

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

//    func switchToTabbar(mainVC: UIViewController,
//                        to navVC: UINavigationController) -> UINavigationController {
//        rootViewController = navVC
//        navVC.setViewControllers([mainVC], animated: true)
//        guard let controller = rootViewController else {
//            return UINavigationController(rootViewController: mainVC)
//        }
//        return controller
//    }

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

protocol TabCoordinatorProtocol {
    var tabBarController: UITabBarController { get set }

    func selectPage(_ page: TabBarPage)

    func setSelectedIndex(_ index: Int)

    func currentPage() -> TabBarPage?
}

//final class TabBarCoordinator: TabCoordinatorProtocol {
//    var navigationController: UINavigationController
//    var tabBarController: UITabBarController
//
//    required init(_ navigationController: UINavigationController) {
//        self.navigationController = navigationController
//        self.tabBarController = .init()
//    }
//
//    func start() {
//        let pages: [TabBarPage] = [.news, .search, .help, .history, .profile]
//        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
//        prepareTabBarController(withTabControllers: controllers)
//    }
//
//    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
//        tabBarController.setViewControllers(tabControllers, animated: true)
//        tabBarController.selectedIndex = TabBarPage.help.pageOrderNumber()
//        tabBarController.tabBar.isTranslucent = false
//        navigationController.viewControllers = [tabBarController]
//    }
//
//    private func getTabController(_ page: TabBarPage) -> UINavigationController {
//        let navController = UINavigationController()
//        navController.setNavigationBarHidden(false, animated: false)
//
//        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
//                                                     image: page.getIcon(),
//                                                     tag: page.pageOrderNumber())
//
//        switch page {
//        case .news:
//            let newsVC = UIViewController()
//            newsVC.view.backgroundColor = .yellow
//            navController.pushViewController(newsVC, animated: true)
//        case .search:
//            let searchVC = UIViewController()
//            searchVC.view.backgroundColor = .systemRed
//            navController.pushViewController(searchVC, animated: true)
//        case .help:
//            let helpVC = HelpCategoriesViewController()
//            navController.pushViewController(helpVC, animated: true)
//        case .history:
//            let historyVC = UIViewController()
//            historyVC.view.backgroundColor = .systemFill
//            navController.pushViewController(historyVC, animated: true)
//        case .profile:
//            let profileVC = UIViewController()
//            profileVC.view.backgroundColor = .charcoalGrey
//            navController.pushViewController(profileVC, animated: true)
//        }
//        navController.navigationBar.standardAppearance = configureNavBarAppearence()
//        navController.navigationBar.compactAppearance = configureNavBarAppearence()
//        navController.navigationBar.scrollEdgeAppearance = configureNavBarAppearence()
//        return navController
//    }
//
//    private func configureNavBarAppearence() -> UINavigationBarAppearance {
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = .leaf
//        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.textStyle3]
//
//        let backButtonAppearance = UIBarButtonItemAppearance(style: .plain)
//        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
//
//        appearance.backButtonAppearance = backButtonAppearance
//        UINavigationBar.appearance().tintColor = .white
//
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().compactAppearance = appearance
//
//        return appearance
//    }
//
//    func currentPage() -> TabBarPage? { TabBarPage.init(index: tabBarController.selectedIndex) }
//
//    func selectPage(_ page: TabBarPage) {
//        tabBarController.selectedIndex = page.pageOrderNumber()
//    }
//
//    func setSelectedIndex(_ index: Int) {
//        guard let page = TabBarPage.init(index: index) else { return }
//
//        tabBarController.selectedIndex = page.pageOrderNumber()
//    }
//}

enum TabBarPage {
    case news
    case search
    case help
    case history
    case profile

    init?(index: Int) {
        switch index {
        case 0:
            self = .news
        case 1:
            self = .search
        case 2:
            self = .help
        case 3:
            self = .history
        case 4:
            self = .profile
        default:
            return nil
        }
    }

    func pageTitleValue() -> String {
        switch self {
        case .news:
            return TabBarConstants.newsVCTitle
        case .search:
            return TabBarConstants.searchVCTitle
        case .help:
            return TabBarConstants.helpVCTitle
        case .history:
            return TabBarConstants.historyVCTitle
        case .profile:
            return TabBarConstants.profileVCTitle
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .news:
            return 0
        case .search:
            return 1
        case .help:
            return 2
        case .history:
            return 3
        case .profile:
            return 4
        }
    }

    func getIcon() -> UIImage? {
        switch self {
        case .news:
            return TabBarConstants.newsVCImage
        case .search:
            return TabBarConstants.searchVCImage
        case .help:
            return nil
        case .history:
            return TabBarConstants.historyVCImage
        case .profile:
            return TabBarConstants.profileVCImage
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
