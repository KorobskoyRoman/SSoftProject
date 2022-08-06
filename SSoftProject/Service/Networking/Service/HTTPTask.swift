//
//  HTTPTask.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 06.08.2022.
//

import Foundation

public typealias HTTPHeaders = [String: String]

/// Виды запросов, можно добавить другие
public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?,
                           urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?,
                                     urlParameters: Parameters?,
                                     additionalHeaders: HTTPHeaders?)
}
