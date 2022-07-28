//
//  RealmEvent.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 27.07.2022.
//

import RealmSwift

class RealmEvent: Object, Decodable, DataBaseModelProtocol {
    @Persisted var id: Int
    @Persisted var image: String
    @Persisted var title: String
    @Persisted var details: String
    @Persisted var date: String
    @Persisted var isDone: Bool
    @Persisted var category: String
    @Persisted var address: String
    @Persisted var phone: String
    @Persisted var details2: String
    @Persisted var details3: String
}
