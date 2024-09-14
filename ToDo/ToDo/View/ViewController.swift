//
//  ViewController.swift
//  ToDo
//
//  Created by Ajit Nevhal on 12/09/24.
//

import SwiftUI
import UIKit


// Main TabView Controller
class ViewController: UITabBarController, UITabBarControllerDelegate {
    
    private var viewModel = TasksViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        let taskListViewController = UIHostingController(rootView: TaskListView(datasource: viewModel))
        let taskNavigationController = UINavigationController(rootViewController: taskListViewController)
        taskNavigationController.tabBarItem = UITabBarItem(title: "Tasks", image: UIImage(systemName: "list.bullet"), tag: 0)

        let categoryListViewController = CategoryTableViewController()
        categoryListViewController.viewModel = viewModel
        let categoryNavigationController = UINavigationController(rootViewController: categoryListViewController)
        categoryNavigationController.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "folder"), tag: 1)
        viewControllers = [taskNavigationController, categoryNavigationController]
        taskListViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
    }

    // Presenting AddTaskViewController
    @objc func addItem() {
        let addTaskVC = AddTaskViewController()
        addTaskVC.viewModel = viewModel
        let navController = UINavigationController(rootViewController: addTaskVC)
        if let sheet = navController.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(navController, animated: true, completion: nil)
    }
}

// Notificatio Center for Many events to one target(many to one)
extension Notification.Name {
    static let taskUpdated = Notification.Name("TaskUpdated")
}
