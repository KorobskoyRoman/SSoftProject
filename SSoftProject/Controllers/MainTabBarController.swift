//
//  MainTabBarController.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 13.07.2022.
//

import UIKit

final class MainTabBarController: UITabBarController {
    private let middleButtonDiameter: CGFloat = 42

    private let redColor: UIColor = UIColor(red: 254.0 / 255.0, green: 116.0 / 255.0, blue: 96.0 / 255.0, alpha: 1.0)
    private let greenColor: UIColor = UIColor(red: 102.0 / 255.0, green: 166.0 / 255.0, blue: 54.0 / 255.0, alpha: 1.0)

    private lazy var middleButton: UIButton = {
        let middleButton = UIButton()
        middleButton.layer.cornerRadius = middleButtonDiameter / 2
        middleButton.backgroundColor = greenColor
        middleButton.translatesAutoresizingMaskIntoConstraints = false
        middleButton.addTarget(self, action: #selector(didPressMiddleButton), for: .touchUpInside)
        return middleButton
    }()

    private lazy var heartImageView: UIImageView = {
        let heartImageView = UIImageView()
        heartImageView.image = TabBarConstants.heartButtonImage
        heartImageView.tintColor = .white
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        return heartImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(CustomTabBar(frame: tabBar.frame), forKey: "tabBar")
        makeUI()
    }

    @objc private func didPressMiddleButton() {
        selectedIndex = TabBarConstants.currentIndexOfMiddleButton
        middleButton.backgroundColor = greenColor
    }

    /// При добавлении новых контроллеров нужно настроить NavigationController
    private func makeUI() {
        tabBar.addSubview(middleButton)
        middleButton.addSubview(heartImageView)

        let newsVC = UIViewController()
        newsVC.view.backgroundColor = .yellow
        newsVC.tabBarItem.title = TabBarConstants.newsVCTitle
        newsVC.tabBarItem.image = TabBarConstants.newsVCImage

        let searchVC = UIViewController()
        searchVC.view.backgroundColor = .systemRed
        searchVC.tabBarItem.title = TabBarConstants.searchVCTitle
        searchVC.tabBarItem.image = TabBarConstants.searchVCImage

        let helpVC = HelpCategoriesViewController() // heart button
        let helpVCNav = UINavigationController(rootViewController: helpVC)
        helpVCNav.tabBarItem.title = TabBarConstants.helpVCTitle

        let historyVC = UIViewController()
        historyVC.view.backgroundColor = .systemFill
        historyVC.tabBarItem.title = TabBarConstants.historyVCTitle
        historyVC.tabBarItem.image = TabBarConstants.historyVCImage

        let profileVC = UIViewController()
        profileVC.view.backgroundColor = .charcoalGrey
        profileVC.tabBarItem.title = TabBarConstants.profileVCTitle
        profileVC.tabBarItem.image = TabBarConstants.profileVCImage

        tabBar.tintColor = greenColor
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: greenColor], for: .selected)

        viewControllers = [newsVC, searchVC, helpVCNav, historyVC, profileVC]
        selectedViewController = viewControllers?[TabBarConstants.currentIndexOfMiddleButton]
        selectedIndex = TabBarConstants.currentIndexOfMiddleButton

        NSLayoutConstraint.activate([
            middleButton.heightAnchor.constraint(equalToConstant: middleButtonDiameter),
            middleButton.widthAnchor.constraint(equalToConstant: middleButtonDiameter),
            middleButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            middleButton.topAnchor.constraint(equalTo: tabBar.topAnchor,
                                              constant: TabBarConstants.Constraints.middleButtonTopAnchor)
        ])

        NSLayoutConstraint.activate([
            heartImageView.heightAnchor.constraint(
                equalToConstant: TabBarConstants.Constraints.heartImageViewHeightAnchor),
            heartImageView.widthAnchor.constraint(
                equalToConstant: TabBarConstants.Constraints.heartImageViewWidthAnchor),
            heartImageView.centerXAnchor.constraint(equalTo: middleButton.centerXAnchor),
            heartImageView.centerYAnchor.constraint(equalTo: middleButton.centerYAnchor)
        ])
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let selectedIndex = self.tabBar.items?.firstIndex(of: item)
        if selectedIndex != TabBarConstants.currentIndexOfMiddleButton { // позиция кнопки
            middleButton.backgroundColor = redColor
        } else {
            middleButton.backgroundColor = greenColor
        }
    }
}

private enum TabBarConstants {
    /// Индекс центральной кнопки
    static let currentIndexOfMiddleButton = 2
    static let heartButtonImage = UIImage(systemName: "heart.fill")

    static let newsVCTitle = "Новости"
    static let newsVCImage = UIImage(systemName: "list.bullet")

    static let searchVCTitle = "Поиск"
    static let searchVCImage = UIImage(systemName: "magnifyingglass")

    static let helpVCTitle = "Помочь"

    static let historyVCTitle = "История"
    static let historyVCImage = UIImage(systemName: "clock.arrow.circlepath")

    static let profileVCTitle = "Профиль"
    static let profileVCImage = UIImage(systemName: "person.crop.circle")

    enum Constraints {
        static let heartImageViewHeightAnchor: CGFloat = 15
        static let heartImageViewWidthAnchor: CGFloat = 18
        static let middleButtonTopAnchor: CGFloat = -10
    }
}

private enum HelpConstants {
    static let backImage = UIImage(named: "backButton")
}
