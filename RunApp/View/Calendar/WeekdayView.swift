//
//  WeekdayView.swift
//  RunApp
//
//  Created by Jack Terry on 3/19/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import UIKit

class WeekdayView: UIView {
    
    // MARK: - Stackview for containing weekday labels
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Lifecycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View setup
extension WeekdayView {
    
    private func setupViews() {
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        let weekdays = ["S", "M", "T", "W", "T", "F", "S"]
        
        for i in 0..<weekdays.count {
            let label = UILabel()
            label.font = UIFont(name: "PingFangHK-Regular", size: 18)
            label.textAlignment = .center
            label.textColor = .white
            label.text = weekdays[i]
            stackView.addArrangedSubview(label)
        }
    }
}
