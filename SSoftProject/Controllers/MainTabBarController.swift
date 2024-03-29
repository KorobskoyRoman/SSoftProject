//
//  MainTabBarController.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 13.07.2022.
//

import UIKit

final class MainTabBarController: UITabBarController {
    weak var coordinator: AppCoordinator?

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

    init(coordinator: AppCoordinator?) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func didPressMiddleButton() {
        selectedIndex = TabBarConstants.currentIndexOfMiddleButton
        middleButton.backgroundColor = greenColor
    }

    /// При добавлении новых контроллеров нужно настроить NavigationController
    private func makeUI() {
        tabBar.addSubview(middleButton)
        middleButton.addSubview(heartImageView)
        setConstraints()
    }

    private func setConstraints() {
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

extension MainTabBarController {
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

extension MainTabBarController: Storyboarded {}

enum TabBarConstants {
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
