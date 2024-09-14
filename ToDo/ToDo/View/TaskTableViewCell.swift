//
//  TaskTableViewCell.swift
//  ToDo
//
//  Created by Ajit Nevhal on 13/09/24.
//

import Foundation
import UIKit

class TaskTableViewCell: UITableViewCell {

    // MARK: - UI Elements
    private let checkboxButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square"), for: .normal) // Unchecked box
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Properties
    private var isChecked: Bool = false
    private var toggleCheckboxAction: (() -> Void)?

    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        configureActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.addSubview(checkboxButton)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            checkboxButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            checkboxButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkboxButton.widthAnchor.constraint(equalToConstant: 24),
            checkboxButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor, constant: 15),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
    private func configureActions() {
        checkboxButton.addTarget(self, action: #selector(checkboxButtonTapped), for: .touchUpInside)
    }
    
    @objc private func checkboxButtonTapped() {
        isChecked.toggle()
        updateCheckboxState()
        toggleCheckboxAction?()
    }
    
    // MARK: - Update Checkbox State
    private func updateCheckboxState() {
        let checkboxImage = isChecked ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
        checkboxButton.setImage(checkboxImage, for: .normal)
    }
    
    // MARK: - Configure Cell
    func configure(withTitle title: String, isChecked: Bool, toggleAction: @escaping () -> Void) {
        titleLabel.text = title
        self.isChecked = isChecked
        toggleCheckboxAction = toggleAction
        updateCheckboxState()
    }
}
