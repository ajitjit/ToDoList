//
//  TasksViewModel.swift
//  ToDo
//
//  Created by Ajit Nevhal on 13/09/24.
//

import Foundation
import SwiftUI

class TasksViewModel: ObservableObject {
    
    
    private var userDefault = UserDefaultManager.shared
    @Published var tasks: [Task] {
        didSet {
            saveItems()
        }
    }
    @Published var categories: [Category] {
        didSet {
            saveItems()
        }
    }
    let itemsKey: String = "tasks_list"
    let catKey: String = "category_list"
    init() {
        tasks = userDefault.fetchTasks() ?? []
        categories = userDefault.fetchCategories() ?? []
    }
    
    func addTask(task: Task) {
        tasks.append(task)
        NotificationCenter.default.post(name: .taskUpdated, object: nil)
    }
    
    func deleteTask(atOffsets: IndexSet) {
        tasks.remove(atOffsets: atOffsets)
        NotificationCenter.default.post(name: .taskUpdated, object: nil)
    }
    
    func deleteTask(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
            NotificationCenter.default.post(name: .taskUpdated, object: nil)
        }
    }
    
    func addCategory(category: Category) {
        if !categories.contains(category) {
            categories.append(category)
            NotificationCenter.default.post(name: .taskUpdated, object: nil)
        }
    }
    
    func deleteCategory(category: Category) {
        guard let index = categories.firstIndex(where: { $0 == category }) else {
            return
        }
        categories.remove(at: index)
        tasks.removeAll { task in
            task.category == category
        }
        NotificationCenter.default.post(name: .taskUpdated, object: nil)
    }
    
    func toggleTaskCompletion(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            NotificationCenter.default.post(name: .taskUpdated, object: nil)
        }
    }
        
    func updateTask(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
            NotificationCenter.default.post(name: .taskUpdated, object: nil)
        }
    }
    
    func saveItems() {
        userDefault.saveTasks(tasks)
        userDefault.saveCategories(categories)
    }
    
}
