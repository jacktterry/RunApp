//
//  DateCell.swift
//  RunApp
//
//  Created by Jack Terry on 3/19/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import UIKit

public protocol ReusableCell: class {
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

class DateCell: UICollectionViewCell, ReusableCell {
    
    public let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PingFangHK-Semibold", size: 18)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public func setupViews(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 20
        
        self.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
