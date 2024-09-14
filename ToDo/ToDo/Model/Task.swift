//
//  Task.swift
//  ToDo
//
//  Created by Ajit Nevhal on 12/09/24.
//

import Foundation

struct Task: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var isCompleted: Bool
    var dueDate: Date
    var category: Category
}

struct Category: Codable, Equatable {
    var title: String
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.title == rhs.title
    }
}
