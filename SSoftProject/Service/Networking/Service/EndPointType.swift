//
//  EndPointType.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 06.08.2022.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
