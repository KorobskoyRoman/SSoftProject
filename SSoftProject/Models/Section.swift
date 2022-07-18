//
//  Section.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 12.07.2022.
//

import Foundation

enum Section: Int, CaseIterable {
    case mainSection

    func description() -> String {
        switch self {
        case .mainSection:
            return SectionInfo.name
        }
    }
}

private enum SectionInfo {
    static let name = "Выберите категорию помощи"
}
