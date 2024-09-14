//
//  AddCategoryViewController.swift
//  ToDo
//
//  Created by Ajit Nevhal on 13/09/24.
//

import Foundation
import UIKit

class AddCategoryViewController: UIViewController {
    
    let categoryTextField = UITextField()
    var viewModel: TasksViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupNavigationBar()
    }
    
    private func setupUI() {
        categoryTextField.placeholder = "Category Name"
        categoryTextField.borderStyle = .roundedRect
        categoryTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryTextField)
        NSLayoutConstraint.activate([
            categoryTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            categoryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Add Category"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addTapped))
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func addTapped() {
        guard let categoryTitle = categoryTextField.text, !categoryTitle.isEmpty else {
            return
        }
        let cateGory = Category(title: categoryTitle)
        viewModel.addCategory(category: cateGory)
//        NotificationCenter.default.post(name: .categoryAdded, object: nil)
        dismiss(animated: true, completion: nil)
    }
}
