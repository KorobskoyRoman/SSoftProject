//
//  Categories.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 12.07.2022.
//

struct Root: Codable {
    let results: [Categories]
}

struct Categories: Codable, Hashable {
    let id: Int64
    let image: String
    let title: String
}
