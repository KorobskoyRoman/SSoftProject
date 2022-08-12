//
//  ConfiguratorProtocols.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 09.08.2022.
//

import UIKit

protocol TabBarConfiguratorProtocol {
    func configure(coordinator: TabBarCoordinator?) -> UITabBarController
}

protocol ConfiguratorProtocol {
    func configure(jsonService: JSONDecoderService?,
                   networkManager: NetworkManager?,
                   coordinator: AppCoordinator) -> UIViewController
}
