//
//  TaskDetailView.swift
//  ToDo
//
//  Created by Ajit Nevhal on 13/09/24.
//

import Foundation
import SwiftUI

struct TaskDetailView: View {
    @Binding var task: Task
    @ObservedObject var datasource: TasksViewModel
    @State private var updatedTitle: String = ""
    @State private var updatedDescription: String = ""
    @State private var updatedCategory: String = ""
    @State private var updatedDueDate: Date = Date()

    @Environment(\.presentationMode) var presentationMode
    @State private var showError = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Title", text: $updatedTitle)
                        .padding()
                        .background(updatedTitle.isEmpty && showError ? Color.red.opacity(0.2) : Color(UIColor.systemBackground))
                        .cornerRadius(8)

                    TextField("Description", text: $updatedDescription)
                        .padding()
                        .background(updatedDescription.isEmpty && showError ? Color.red.opacity(0.2) : Color(UIColor.systemBackground))
                        .cornerRadius(8)

                    TextField("Category", text: $updatedCategory)
                        .padding()
                        .background(updatedCategory.isEmpty && showError ? Color.red.opacity(0.2) : Color(UIColor.systemBackground))
                        .cornerRadius(8)

                    DatePicker("Due Date", selection: $updatedDueDate, displayedComponents: [.date])
                }
            }
            .navigationTitle("Edit Task")
            .navigationBarItems(trailing: Button("Save") {
                if validateFields() {
                    saveTask()
                    presentationMode.wrappedValue.dismiss()
                } else {
                    showError = true
                }
            })
        }
        .onAppear {
            updatedTitle = task.title
            updatedDescription = task.description
            updatedCategory = task.category.title
            updatedDueDate = task.dueDate
        }
    }

    private func validateFields() -> Bool {
        return !updatedTitle.isEmpty && !updatedDescription.isEmpty && !updatedCategory.isEmpty
    }

    private func saveTask() {
        task.title = updatedTitle
        task.description = updatedDescription
        task.category = Category(title: updatedCategory)
        task.dueDate = updatedDueDate
        datasource.updateTask(task: task)
        datasource.addCategory(category: task.category)
    }
}
