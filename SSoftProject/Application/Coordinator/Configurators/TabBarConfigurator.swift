//
//  TabBarConfigurator.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 08.08.2022.
//

import UIKit

class TabBarConfigurator: TabBarConfiguratorProtocol {
    func configure(coordinator: AppCoordinator?) -> UITabBarController {
        let tabbarControler = MainTabBarController()
        tabbarControler.modalPresentationStyle = .fullScreen
        tabbarControler.modalTransitionStyle = .flipHorizontal
        tabbarControler.coordinator = coordinator
        return tabbarControler
    }
}
