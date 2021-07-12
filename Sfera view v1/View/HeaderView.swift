//
//  HeaderView.swift
//  Sfera view v1
//
//  Created by Максим on 08.07.2021.
//

import UIKit

class HeaderView: UIView {

    // MARK: - Views
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor(named: String.colors.grayTitle.rawValue)
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var title: String = "" {
        didSet{
            headerLabel.text = title
            layoutIfNeeded()
        }
    }
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        addSubview(headerLabel)
        addSubview(lineView)
        backgroundColor = UIColor(named: String.colors.gray.rawValue)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    private func setupLayout() {
        headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        
        lineView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lineView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        lineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
    }
}
