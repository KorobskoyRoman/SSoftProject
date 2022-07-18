//
//  Events.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 18.07.2022.
//

struct Event: Codable, Hashable {
    let id: Int
    let image: String
    let title: String
    let details: String
    let date: String
}
