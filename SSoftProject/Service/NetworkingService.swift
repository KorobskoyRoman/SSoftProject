//
//  NetworkingService.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 04.08.2022.
//

import Alamofire
import Foundation
import RealmSwift

//protocol NetworkingServiceProtocol {
//    func fetchCategoriesWithAlamofire(completion: @escaping (Result<[RealmCategories], RequestError>) -> Void)
//    func fetchEventsWithAlamofire(completion: @escaping (Result<[RealmEvent], RequestError>) -> Void)
//    func fetchCategoriesWithURL(completion: @escaping (Result<[RealmCategories], RequestError>) -> Void)
//    func fetchEventsWithURL(completion: @escaping (Result<[RealmEvent], RequestError>) -> Void)
//    func fetchData()
//}
//
//enum RequestError: Error {
//    case decode
//    case invalidURL
//    case noResponse
//    case unknown
//
//    var customMessage: String {
//        switch self {
//        case .decode:
//            return "Decode error"
//        case .invalidURL:
//            return "Invalid URL"
//        case .noResponse:
//            return "Response is invalid"
//        default:
//            return "Unknown error"
//        }
//    }
//}
//
//final class NetworkingService: NetworkingServiceProtocol {
//
//    private let jsonService = JSONDecoderService()
//
//    func fetchCategoriesWithAlamofire(completion: @escaping (Result<[RealmCategories], RequestError>) -> Void) {
//        let request = AF.request(UrlConst.categoriesUrl)
//        request.responseDecodable(of: [RealmCategories].self) { data in
//            guard let cats = data.value else {
//                completion(.failure(.noResponse))
//                return
//            }
//            completion(.success(cats))
//        }
//    }
//
//    func fetchEventsWithAlamofire(completion: @escaping (Result<[RealmEvent], RequestError>) -> Void) {
//        let request = AF.request(UrlConst.eventsUrl)
//        request.responseDecodable(of: [RealmEvent].self) { data in
//            guard let events = data.value else {
//                completion(.failure(.noResponse))
//                return
//            }
//            completion(.success(events))
//        }
//    }
//
//    func fetchCategoriesWithURL(completion: @escaping (Result<[RealmCategories], RequestError>) -> Void) {
//        guard let url = URL(string: UrlConst.categoriesUrl) else {
//            completion(.failure(.invalidURL))
//            return
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if error != nil {
//                completion(.failure(.noResponse))
//                return
//            } else if let data = data,
//                      let response = response as? HTTPURLResponse,
//                      response.statusCode == 200 {
//                let decoder = JSONDecoder()
//                do {
//                    let fetchedData = try decoder.decode([RealmCategories].self, from: data)
//                    return completion(.success(fetchedData))
//                } catch {
//                    completion(.failure(.decode))
//                }
//            } else {
//                completion(.failure(.unknown))
//            }
//        } .resume()
//    }
//
//    func fetchEventsWithURL(completion: @escaping (Result<[RealmEvent], RequestError>) -> Void) {
//        guard let url = URL(string: UrlConst.eventsUrl) else {
//            completion(.failure(.invalidURL))
//            return
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if error != nil {
//                completion(.failure(.noResponse))
//            } else if let data = data,
//                      let response = response as? HTTPURLResponse,
//                      response.statusCode == 200 {
//                let decoder = JSONDecoder()
//                do {
//                    let fetchedData = try decoder.decode([RealmEvent].self, from: data)
//                    return completion(.success(fetchedData))
//                } catch {
//                    completion(.failure(.decode))
//                }
//            } else {
//                completion(.failure(.unknown))
//            }
//        } .resume()
//    }
//
//    func fetchData() {
//        if Network.isAlamofire {
//            fetchCategoriesWithAlamofire { result in
//                switch result {
//                case .success(let cats):
//                    print("----------------GETTING CATEGORIES FROM NETWORK----------------")
//                    RealmService.shared.getCategoriesIntoRealmWithNetwork(from: cats)
//                case .failure(let error):
//                    print("----------------GETTING CATEGORIES FROM LOCAL----------------")
//                    self.jsonService.decodeToDataBase()
//                    print(error)
//                }
//            }
//            fetchEventsWithAlamofire { result in
//                switch result {
//                case .success(let events):
//                    print("----------------GETTING EVENTS FROM NETWORK----------------")
//                    RealmService.shared.getEventsIntoRealmWithNetwork(from: events)
//                case .failure(let error):
//                    print("----------------GETTING EVENTS FROM LOCAL----------------")
//                    self.jsonService.decodeToDataBase()
//                    print(error)
//                }
//            }
//        } else {
//            fetchCategoriesWithURL { result in
//                switch result {
//                case .success(let cats):
//                    print("----------------GETTING CATEGORIES FROM NETWORK----------------")
//                    RealmService.shared.getCategoriesIntoRealmWithNetwork(from: cats)
//                case .failure(let error):
//                    print("----------------GETTING CATEGORIES FROM LOCAL----------------")
//                    self.jsonService.decodeToDataBase()
//                    print(error)
//                }
//            }
//            fetchEventsWithURL { result in
//                switch result {
//                case .success(let events):
//                    print("----------------GETTING EVENTS FROM NETWORK----------------")
//                    RealmService.shared.getEventsIntoRealmWithNetwork(from: events)
//                case .failure(let error):
//                    print("----------------GETTING EVENTS FROM LOCAL----------------")
//                    self.jsonService.decodeToDataBase()
//                    print(error)
//                }
//            }
//        }
//    }
//}
