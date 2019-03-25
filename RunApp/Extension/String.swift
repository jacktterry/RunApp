//
//  StringExtension.swift
//  RunApp
//
//  Created by Jack Terry on 3/19/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import Foundation

extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyy-MM-dd"
        return formatter
    }()
    
    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
}
