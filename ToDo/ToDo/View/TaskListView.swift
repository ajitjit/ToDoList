//
//  TaskListView.swift
//  ToDo
//
//  Created by Ajit Nevhal on 12/09/24.
//

import SwiftUI

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()

struct TaskListView: View {
    @ObservedObject var datasource: TasksViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach($datasource.tasks) { $task in
                    TaskCellView(datasource: datasource, task: $task)
                }
                .onDelete(perform: deleteTask)
            }
            .navigationTitle("Tasks")
            .overlay {
                if datasource.tasks.isEmpty {
                    ContentUnavailableView {
                        Label("No Pending Tasks", systemImage: "tray.fill")
                    }
                }
            }
        }
    }

    private func deleteTask(at offsets: IndexSet) {
        datasource.deleteTask(atOffsets: offsets)
    }
}
