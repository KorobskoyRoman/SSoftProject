//
//  Categories.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 12.07.2022.
//

struct Categories: Codable, Hashable, DataBaseModelProtocol {
    let id: Int
    let image: String
    let title: String
}

protocol DataBaseModelProtocol {} // как адаптировать под Realm и Core Data?
