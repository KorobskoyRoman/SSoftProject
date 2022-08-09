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
    func perfornTransition(with type: Transition)
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
            let splashVC = SplashScreenViewController.instantiate()
            return splashVC
        case .help:
            return HelpCategoriesViewController()
        case .charity:
            return CharityEventsViewController()
        case .detailEvent:
            return DetailEventViewController()
        }
    }
}

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // swiftlint:disable force_cast
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
        // swiftlint:enable force_cast
    }
}
