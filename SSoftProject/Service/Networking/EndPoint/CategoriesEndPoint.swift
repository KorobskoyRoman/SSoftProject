//
//  CategoriesEndPoint.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 06.08.2022.
//

import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum CategoriesApi {
    case category
    case event
}

extension CategoriesApi: EndPointType {

    var environmentBaseURL: String {
        switch NetworkManager.enviroment {
        case .production: return "https://ssoftproject-4a167-default-rtdb.europe-west1.firebasedatabase.app/"
        case .qa: return "https://ssoftproject-4a167-default-rtdb.europe-west1.firebasedatabase.app/"
        case .staging: return "https://ssoftproject-4a167-default-rtdb.europe-west1.firebasedatabase.app/"
        }
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }

    var path: String {
        switch self {
        case .category:
            return "categories.json"
        case .event:
            return "events.json"
        }
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        switch self {
        default:
            return .request
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }
}
