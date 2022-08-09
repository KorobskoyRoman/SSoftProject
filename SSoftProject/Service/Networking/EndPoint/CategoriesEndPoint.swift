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
        case .production: return UrlConst.url
        case .qa: return UrlConst.url
        case .staging: return UrlConst.url
        }
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }

    var path: String {
        switch self {
        case .category:
            return UrlConst.categoriesUrl
        case .event:
            return UrlConst.eventsUrl
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
