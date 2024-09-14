//
//  PersistenceManager.swift
//  ToDo
//
//  Created by Ajit Nevhal on 12/09/24.
//

import Foundation

class PersistenceManager {
    private let tasksKey = "Todo_List_Tasks"

    static let shared = PersistenceManager()

    func saveTasks(_ tasks: [Task]) {
        if let data = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(data, forKey: tasksKey)
        }
    }

    func loadTasks() -> [Task] {
        if let data = UserDefaults.standard.data(forKey: tasksKey),
           let tasks = try? JSONDecoder().decode([Task].self, from: data) {
            return tasks
        }
        return []
    }
}

