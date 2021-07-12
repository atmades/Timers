//
//  TimerCell.swift
//  Sfera view v1
//
//  Created by Максим on 08.07.2021.
//

import UIKit

protocol TimerCellDelegate: AnyObject {
    func didEndTimer(index: Int)
}

class TimerCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "TimerCell"
    
    weak var delegate: TimerCellDelegate?
    
    private var timer = Timer()
    private var secondDisplay = 0 {
        didSet {
            timerLabel.text = String(secondDisplay)
        }
    }
    
    private var index = 0
    
    // MARK: - Views
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let boxView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Public Func
    public func setTitle(title: String) {
        nameLabel.text = title
    }
    
    public func setupCell(newTimer: TimerElement, index: Int) {
        let sec = newTimer.sec
        let name = newTimer.name 
        secondDisplay = sec
        self.index = index
        nameLabel.text = name
        timerLabel.text = String(sec)
        changeTimer()
    }
    
    private func changeTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }
    
    @objc func countDown() {
        if secondDisplay > 0 {
            secondDisplay -= 1
        } else {
            timer.invalidate()
            delegate?.didEndTimer(index: index)
        }
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor(named: String.colors.gray.rawValue)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(timerLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    private func setupLayout() {
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
