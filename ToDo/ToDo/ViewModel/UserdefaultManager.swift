//
//  UserdefaultManager.swift
//  ToDo
//
//  Created by Ajit Nevhal on 14/09/24.
//

import Foundation
import Foundation

class UserDefaultManager {
    
    // MARK: - Properties
    static let shared = UserDefaultManager() // Singleton instance
    
    private let defaults = UserDefaults.standard
    
    // MARK: - UserDefaults Keys
    private enum Keys {
        static let tasks = "tasks_list"
        static let categories = "categories_list"
    }
    
    // MARK: - Initializer
    private init() {}
    
    // MARK: - Task Handling
    func saveTasks(_ tasks: [Task]) {
        if let encodedTasks = try? JSONEncoder().encode(tasks) {
            defaults.set(encodedTasks, forKey: Keys.tasks)
        }
    }
    
    func fetchTasks() -> [Task]? {
        guard let data = defaults.data(forKey: Keys.tasks),
              let decodedTasks = try? JSONDecoder().decode([Task].self, from: data) else {
            return nil
        }
        return decodedTasks
    }
    
    func removeTasks() {
        defaults.removeObject(forKey: Keys.tasks)
    }
        
    func saveCategories(_ categories: [Category]) {
        if let encodedTasks = try? JSONEncoder().encode(categories) {
            defaults.set(encodedTasks, forKey: Keys.categories)
        }
    }
    
    func fetchCategories() -> [Category]? {
        guard let data = defaults.data(forKey: Keys.categories),
              let decodedTasks = try? JSONDecoder().decode([Category].self, from: data) else {
            return nil
        }
        return decodedTasks
    }
}
