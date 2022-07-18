//
//  SetupCategories.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 12.07.2022.
//

import UIKit

final class SetupCategories {
    private let mainSectionTitles = ["Дети", "Взрослые", "Пожилые", "Животные", "Мероприятия"]
    private let mainSectionImages = ["childs", "adults", "aged", "animals", "events"]

    private func createModel(titles: [String], images: [String]) -> [Categories] {
        var models = [Categories]()
        guard !titles.isEmpty && !images.isEmpty else { return models }
        for (index, name) in titles.enumerated() {
            let model = Categories(image: images[index], title: name)
            models.append(model)
        }
        return models
    }

    public func createItems() -> [Categories] {
        return createModel(titles: mainSectionTitles, images: mainSectionImages)
    }
}
