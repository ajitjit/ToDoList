//
//  CategoryTableViewController.swift
//  ToDo
//
//  Created by Ajit Nevhal on 12/09/24.
//

import Foundation
import UIKit

private enum CellType {
    case categoryCell, taskCell
    init(indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row)  {
        case (_,0): self = .categoryCell
        default: self = .taskCell
        }
    }
    static var allCases: [CellType] = [.categoryCell, .taskCell]
}

class CategoryTableViewController: UITableViewController {
    var viewModel: TasksViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Categories"
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "TaskCellView")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        addObservation()
    }
    
    
    private func addObservation() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleAddition(_:)), name: .taskUpdated, object: nil)
        
    }
    
    @objc func addItem() {
        let addCategoryVC = AddCategoryViewController()
        addCategoryVC.viewModel = viewModel
        let navController = UINavigationController(rootViewController: addCategoryVC)
        if let sheet = navController.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(navController, animated: true, completion: nil)
    }
    
    @objc private func handleAddition(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return  viewModel.categories.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category =  viewModel.categories[section]
        return viewModel.tasks.filter { $0.category == category }.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category =  viewModel.categories[indexPath.section]
        // First Cell is Category
        switch CellType(indexPath: indexPath) {
        case .categoryCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
            cell.textLabel?.text = category.title
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            cell.textLabel?.textAlignment = .left
            cell.backgroundColor = .lightGray
            return cell
        case .taskCell:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCellView", for: indexPath) as? TaskTableViewCell else {
                return UITableViewCell()
            }
            let categoryTasks = viewModel.tasks.filter { $0.category == category }
            let task = categoryTasks[indexPath.row - 1]
            cell.configure(withTitle: task.title, isChecked: task.isCompleted) {
                self.viewModel.toggleTaskCompletion(task: task)
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let category =  viewModel.categories[indexPath.section]
        let categoryTasks = viewModel.tasks.filter { $0.category == category }
        switch CellType(indexPath: indexPath) {
        case .categoryCell:
            let category =  viewModel.categories[indexPath.section]
            // Deleting Category should delete All Tasks under it
            viewModel.deleteCategory(category: category)
        case .taskCell:
            viewModel.deleteTask(task: categoryTasks[indexPath.row - 1])
        }
    }
}
