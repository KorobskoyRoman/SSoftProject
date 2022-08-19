//
//  Collection+.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 19.08.2022.
//

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
