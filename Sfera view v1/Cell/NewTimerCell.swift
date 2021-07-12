//
//  NewTimerCell.swift
//  Sfera view v1
//
//  Created by Максим on 08.07.2021.
//

import UIKit

protocol NewTimerDelegate: AnyObject {
    func didTapAddTimerButton(timer: TimerElement)
}

class NewTimerCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "NewTimerCell"
    weak var delegate: NewTimerDelegate?
    
    // MARK: - Views
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: String.colors.gray.rawValue)
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: String.colors.grayDark.rawValue)?.cgColor
        textField.placeholder = String.placeholders.nameTimer.rawValue
        textField.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        textField.keyboardType = .alphabet
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var secTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: String.colors.gray.rawValue)
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: String.colors.grayDark.rawValue)?.cgColor
        textField.placeholder = String.placeholders.secTime.rawValue
        textField.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var addTimerButton: UIButton = {
        let button = UIButton()
        let color = UIColor(named: String.colors.grayDark.rawValue)
        button.setTitleColor(.link, for: .normal)
        button.setTitle(String.buttons.addTimer.rawValue, for: .normal)
        button.backgroundColor = color
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tapButton(_ sender: UIButton) {
        guard let name = nameTextField.text, name != "" else {
            print("имя пусто")
            return
        }
        guard let secondString = secTextField.text, secondString != "" else {
            print("время пусто")
            return
        }
        guard let second = Int(secondString) else { return }
        if second == 0  {
            print("введите значение больше 0 \(second)")
            return
        } else {
            let timer = TimerElement(name: name, sec: second)
            delegate?.didTapAddTimerButton(timer: timer)
            nameTextField.text = nil
            secTextField.text = nil
        }
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .white
        contentView.addSubview(nameTextField)
        contentView.addSubview(secTextField)
        contentView.addSubview(addTimerButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    private func setupLayout() {
        nameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        secTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16).isActive = true
        secTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        secTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor).isActive = true
        secTextField.heightAnchor.constraint(equalToConstant: 24).isActive = true

        addTimerButton.topAnchor.constraint(equalTo: secTextField.bottomAnchor, constant: 24).isActive = true
        addTimerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        addTimerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        addTimerButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}
