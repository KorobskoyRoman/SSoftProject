//
//  NetworkingService.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 04.08.2022.
//

import Alamofire

final class NetworkingService {
    func fetchCategories(completion: @escaping ([Categories]) -> Void) {
        let request = AF.request(UrlConst.categories)
        request.responseDecodable(of: [Categories].self) { data in
            guard let cats = data.value else { return }
            completion(cats)
        }
    }

    func fetchEvents(completion: @escaping ([Event]) -> Void) {
        let request = AF.request(UrlConst.events)
        request.responseDecodable(of: [Event].self) { data in
            guard let events = data.value else { return }
            completion(events)
        }
    }
}
