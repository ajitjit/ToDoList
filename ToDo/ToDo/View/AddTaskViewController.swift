//
//  AddTaskViewController.swift
//  ToDo
//
//  Created by Ajit Nevhal on 13/09/24.
//

import Foundation
import UIKit

class AddTaskViewController: UIViewController {
    
    
    var viewModel: TasksViewModel!
    let titleTextField = UITextField()
    let descriptionTextField = UITextField()
    let datePicker = UIDatePicker()
    let categoryTextField = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupUI()
        setupNavigationBar()
    }
    
    private func setupUI() {
        // Title Field
        titleTextField.placeholder = "Task Title"
        titleTextField.borderStyle = .roundedRect
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleTextField)
        
        // Description Field
        descriptionTextField.placeholder = "Description"
        descriptionTextField.borderStyle = .roundedRect
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionTextField)
        
        // Category Field
        categoryTextField.placeholder = "Category"
        categoryTextField.borderStyle = .roundedRect
        categoryTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryTextField)
        
        // Due Date Field (Date Picker)
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)
        
        // Layout
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            categoryTextField.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 20),
            categoryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            datePicker.topAnchor.constraint(equalTo: categoryTextField.bottomAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Add Task"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addTapped))
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func addTapped() {
        guard let title = titleTextField.text, !title.isEmpty,
              let description = descriptionTextField.text, !description.isEmpty,
              let categoryTitle = categoryTextField.text, !categoryTitle.isEmpty else {
            return
        }
        let category = Category(title: categoryTitle)
//        NotificationCenter.default.post(name: .taskAdded, object: nil)
        let newTask = Task(title: title, description: description, isCompleted: false, dueDate: datePicker.date, category: category)
        viewModel.addTask(task: newTask)
        viewModel.addCategory(category: category)
//        NotificationCenter.default.post(name: .taskAdded, object: nil)
        dismiss(animated: true, completion: nil)
    }
}
