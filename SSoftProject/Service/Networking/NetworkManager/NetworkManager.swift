//
//  NetworkManager.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 06.08.2022.
//

import Foundation
import Alamofire

enum NetworkResponse: String, Error {
    case success
    case authenticationError = "auth error"
    case badReques = "bad request"
    case outdated = "url is outdated"
    case failed = "request failed"
    case noData = "response returned no data to decode"
    case unableToDecode = "can't decode response"
}

enum RequestResult<String> {
    case success
    case failure(String)
}

struct NetworkManager {
    static let enviroment: NetworkEnvironment = .production
    static let apiKey = ""
    private let router = Router<CategoriesApi>()

    func getCategories(completion: @escaping (Result<[RealmCategories], Error>) -> Void) {
        router.request(.category) { data, response, error in

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(.failure(NetworkResponse.noData))
                        return
                    }
                    do {
                        //                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        let apiResponse = try JSONDecoder().decode([RealmCategories].self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.unableToDecode))
                    }
                case .failure(let error):
                    print(error)
                    completion(.failure(NetworkResponse.failed))
                }
            }
        }
    }

    func getEvents(completion: @escaping (Result<[RealmEvent], Error>) -> Void) {
        router.request(.event) { data, response, error in

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(.failure(NetworkResponse.noData))
                        return
                    }
                    do {
                        //                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        let apiResponse = try JSONDecoder().decode([RealmEvent].self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.unableToDecode))
                    }
                case .failure(let error):
                    print(error)
                    completion(.failure(NetworkResponse.failed))
                }
            }
        }
    }

    func fetchCategoriesWithAlamofire(completion: @escaping (Result<[RealmCategories],
                                                             NetworkResponse>) -> Void) {
        let url = URL(string: UrlConst.url)
        guard var url = url else {
            completion(.failure(NetworkResponse.badReques))
            return
        }
        url.appendPathComponent(UrlConst.categoriesUrl)
        let request = AF.request(url)
        request.responseDecodable(of: [RealmCategories].self) { data in
            guard let cats = data.value else {
                completion(.failure(.noData))
                return
            }
            completion(.success(cats))
        }
    }

    func fetchEventsWithAlamofire(completion: @escaping (Result<[RealmEvent],
                                                         NetworkResponse>) -> Void) {
        let url = URL(string: UrlConst.url)
        guard var url = url else {
            completion(.failure(NetworkResponse.badReques))
            return
        }
        url.appendPathComponent(UrlConst.eventsUrl)
        let request = AF.request(url)
        request.responseDecodable(of: [RealmEvent].self) { data in
            guard let events = data.value else {
                completion(.failure(.noData))
                return
            }
            completion(.success(events))
        }
    }

    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> RequestResult<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badReques.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
