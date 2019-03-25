//
//  MonthView.swift
//  RunApp
//
//  Created by Jack Terry on 3/19/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import UIKit

protocol MonthViewDelegate: class {
    func didChange(month: Int, year: Int)
}

class MonthView: UIView {
    
    // MARK: - Internal properties
    private let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    private var currentMonthIndex: Int = 0
    private var currentYear: Int = 0
    public var delegate: MonthViewDelegate?
    
    // MARK: - Outlets
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PingFangHK-Regular", size: 24)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let decrementMonthButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(decrementMonth), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let incrementMonthButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "forward"), for: .normal)
        button.addTarget(self, action: #selector(incrementMonth), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Public initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
        currentYear = Calendar.current.component(.year, from: Date())
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Button methods
    @objc private func decrementMonth() {
        currentMonthIndex -= 1
        if currentMonthIndex < 0 {
            currentMonthIndex = 11
            currentYear -= 1
        }
        
        monthLabel.text = "\(months[currentMonthIndex]) \(currentYear)"
        delegate?.didChange(month: currentMonthIndex, year: currentYear)
    }
    
    @objc private func incrementMonth() {
        currentMonthIndex += 1
        if currentMonthIndex > 11 {
            currentMonthIndex = 0
            currentYear += 1
        }
        
        monthLabel.text = "\(months[currentMonthIndex]) \(currentYear)"
        delegate?.didChange(month: currentMonthIndex, year: currentYear)
    }
}

// MARK: - View setup
extension MonthView {
    
    private func setupViews() {
        addSubview(monthLabel)
        monthLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        monthLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        monthLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        monthLabel.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        monthLabel.text = "\(months[currentMonthIndex]) \(currentYear)"
        
        addSubview(decrementMonthButton)
        decrementMonthButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        decrementMonthButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 8)
        decrementMonthButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        decrementMonthButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        addSubview(incrementMonthButton)
        incrementMonthButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        incrementMonthButton.rightAnchor.constraint(equalTo: rightAnchor, constant: 8).isActive = true
        incrementMonthButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        incrementMonthButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
}
