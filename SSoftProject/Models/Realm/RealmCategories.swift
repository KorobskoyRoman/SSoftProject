//
//  RealmCategories.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 27.07.2022.
//

import RealmSwift

class RealmCategories: Object, Decodable {
    @Persisted var id: Int64 = 0
    @Persisted var image: String = ""
    @Persisted var title: String = ""
}
