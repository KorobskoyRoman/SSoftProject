//
//  NetworkingService.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 04.08.2022.
//

import Alamofire
import Foundation
import RealmSwift

protocol NetworkingServiceProtocol {
    func fetchCategoriesWithAlamofire(completion: @escaping ([RealmCategories]?, RequestError?) -> Void)
    func fetchEventsWithAlamofire(completion: @escaping ([RealmEvent]?, RequestError?) -> Void)
    func fetchCategoriesWithURL(completion: @escaping ([RealmCategories]?, RequestError?) -> Void)
    func fetchEventsWithURL(completion: @escaping ([RealmEvent]?, RequestError?) -> Void)
    func fetchData()
}

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unknown

    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .invalidURL:
            return "Invalid URL"
        case .noResponse:
            return "Response is invalid"
        default:
            return "Unknown error"
        }
    }
}

final class NetworkingService: NetworkingServiceProtocol {

    private let jsonService = JSONDecoderService()

    func fetchCategoriesWithAlamofire(completion: @escaping ([RealmCategories]?, RequestError?) -> Void) {
        let request = AF.request(UrlConst.categories)
        request.responseDecodable(of: [RealmCategories].self) { data in
            guard let cats = data.value else {
                completion(nil, RequestError.invalidURL)
                return
            }
            completion(cats, nil)
        }
    }

    func fetchEventsWithAlamofire(completion: @escaping ([RealmEvent]?, RequestError?) -> Void) {
        let request = AF.request(UrlConst.events)
        request.responseDecodable(of: [RealmEvent].self) { data in
            guard let events = data.value else {
                completion(nil, RequestError.invalidURL)
                return
            }
            completion(events, nil)
        }
    }

    func fetchCategoriesWithURL(completion: @escaping ([RealmCategories]?, RequestError?) -> Void) {
        guard let url = URL(string: UrlConst.categories) else {
            completion(nil, .invalidURL)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                return completion(nil, .noResponse)
            } else if let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let fetchedData = try decoder.decode([RealmCategories].self, from: data)
                    return completion(fetchedData, nil)
                } catch {
                    completion(nil, .decode)
                }
            } else {
                completion(nil, .unknown)
            }
        } .resume()
    }

    func fetchEventsWithURL(completion: @escaping ([RealmEvent]?, RequestError?) -> Void) {
        guard let url = URL(string: UrlConst.events) else {
            completion(nil, .invalidURL)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                return completion(nil, .noResponse)
            } else if let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let fetchedData = try decoder.decode([RealmEvent].self, from: data)
                    return completion(fetchedData, nil)
                } catch {
                    completion(nil, .decode)
                }
            } else {
                completion(nil, .unknown)
            }
        } .resume()
    }

    func fetchData() {
        if Network.isAlamofire {
            fetchCategoriesWithAlamofire { cats, err in
                if let err = err {
                    print(err.localizedDescription)
                    print("----------------GETTING CATEGORIES FROM LOCAL----------------")
                    self.jsonService.decodeToDataBase()
                    return
                }
                guard let cats = cats else { return }
                print("----------------GETTING CATEGORIES FROM NETWORK----------------")
                RealmService.shared.getCategoriesIntoRealmWithNetwork(from: cats)
            }
            fetchEventsWithAlamofire { events, err in
                if let err = err {
                    print(err.localizedDescription)
                    print("----------------GETTING EVENTS FROM LOCAL----------------")
                    self.jsonService.decodeToDataBase()
                    return
                }
                guard let events = events else { return }
                print("----------------GETTING EVENTS FROM NETWORK----------------")
                RealmService.shared.getEventsIntoRealmWithNetwork(from: events)
            }
        } else {
            fetchCategoriesWithURL { cats, err in
                if let err = err {
                    print(err)
                    print("----------------GETTING CATEGORIES FROM LOCAL----------------")
                    self.jsonService.decodeToDataBase()
                    return
                }
                guard let cats = cats else { return }
                print("----------------GETTING CATEGORIES FROM NETWORK----------------")
                RealmService.shared.getCategoriesIntoRealmWithNetwork(from: cats)
            }
            fetchEventsWithURL { events, err in
                if let err = err {
                    print(err)
                    print("----------------GETTING EVENTS FROM LOCAL----------------")
                    self.jsonService.decodeToDataBase()
                    return
                }
                guard let events = events else { return }
                print("----------------GETTING EVENTS FROM NETWORK----------------")
                RealmService.shared.getEventsIntoRealmWithNetwork(from: events)
            }
        }
    }
}
