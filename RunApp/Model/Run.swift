//
//  Run.swift
//  RunApp
//
//  Created by Jack Terry on 3/20/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import Foundation

class Run {
    
    private let distance: String
    private let time: String
    private let pace: String
    private let date: String
    
    public init(distance: String, time: String, pace: String, date: String) {
        self.distance = distance
        self.time = time
        self.pace = pace
        self.date = date
    }
    
    public func getDistance() -> String {
        return distance
    }
    
    public func getTime() -> String {
        return time
    }
    
    public func getPace() -> String {
        return pace
    }
    
    public func getDate() -> String {
        return date
    }
    
}
