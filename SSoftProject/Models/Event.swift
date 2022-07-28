//
//  Events.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 18.07.2022.
//

struct Event: Codable, Hashable, DataBaseModelProtocol {
    let id: Int
    let image: String
    let title: String
    let details: String
    let date: String
    let isDone: Bool
    let category: String
    let address: String
    let phone: String
    let details2: String
    let details3: String
}
