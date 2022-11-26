//
//  Book.swift
//  POC Book Animation
//
//  Created by Maria Letícia Dutra de Oliveira on 22/11/22.
//

import SwiftUI

struct Book: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var title: String
    var imageName: String
}

var sampleBooks: [Book] = [
    .init(title: "Sweetener", imageName: "Book 1"),
    .init(title: "Renaissance", imageName: "Book 2"),
    .init(title: "Lemonade", imageName: "Book 3"),
    .init(title: "Born Pink", imageName: "Book 4")
]
