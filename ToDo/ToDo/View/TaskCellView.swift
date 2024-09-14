//
//  SingleTaskView.swift
//  ToDo
//
//  Created by Ajit Nevhal on 13/09/24.
//

import SwiftUI

struct TaskCellView: View {
    @ObservedObject var datasource: TasksViewModel
    @Binding var task: Task
    @State private var isEditing = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                    toggleTaskCompletion()
                }) {
                    Image(systemName: task.isCompleted ? "checkmark.square" : "square")
                }
                .buttonStyle(PlainButtonStyle())
                Text(task.title)
                    .font(.headline)
                Spacer()
                Button(action: {
                    isEditing.toggle()
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .buttonStyle(PlainButtonStyle())
            }

            // Task description and due date
            Text(task.description).font(.subheadline)
            Text("Due: \(task.dueDate, formatter: dateFormatter)").font(.footnote)
        }
        .sheet(isPresented: $isEditing) {
            TaskDetailView(task: $task, datasource: datasource)
        }
    }
    
    private func toggleTaskCompletion() {
        task.isCompleted.toggle()
        datasource.updateTask(task: task)
    }
    
}



