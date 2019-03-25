//
//  RunDetailView.swift
//  RunApp
//
//  Created by Jack Terry on 3/20/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import UIKit

class RunDetailView: UIView {
    
    // MARK: - Outlets
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PingFangHK-Regular", size: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PingFangHK-Regular", size: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let paceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PingFangHK-Regular", size: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weekMileageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PingFangHK-Regular", size: 20)
        label.textColor = .white
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let monthMileageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PingFangHK-Regular", size: 20)
        label.textColor = .white
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let yearMileageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PingFangHK-Regular", size: 20)
        label.textColor = .white
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var run: Run? {
        didSet {
            distanceLabel.text = run?.getDistance() == nil ? "0 mi" : run!.getDistance() + " mi"
            timeLabel.text = run?.getTime() == nil ? "" : run?.getTime()
            paceLabel.text = run?.getPace() == nil ? "" : run?.getPace()
            weekMileageLabel.text = "Week: " + getWeekMileage() + " mi"
            monthMileageLabel.text = "Month: " + getMonthMileage() + " mi"
            yearMileageLabel.text = "Year: " + getYearMileage() + " mi"
        }
    }
    
    private var selectedDate: Date?
    
    // MARK: - Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveRun(_:)), name: .didReceiveRun, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveSelectedDate(_:)), name: .didReceiveDateSelected, object: nil)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onDidReceiveRun(_ notification: Notification) {
        if let data = notification.userInfo as? [String: Run] {
            for (_, run) in data {
                self.run = run
            }
        } else {
            self.run = nil
        }
    }
    
    @objc private func onDidReceiveSelectedDate(_ notification: Notification) {
        if let data = notification.userInfo as? [Date: Date] {
            for (_, date) in data {
                self.selectedDate = date
            }
        }
    }
    
    private func getWeekMileage() -> String {
        var mileage = 0.0
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yy"
        let selectedDay = Calendar.current.startOfDay(for: selectedDate ?? Date())
        let dayOfWeek = Calendar.current.component(.weekday, from: selectedDay)
        let weekdays = Calendar.current.range(of: .weekday, in: .weekOfYear, for: selectedDay)!
        let days = (weekdays.lowerBound ..< weekdays.upperBound)
            .compactMap { Calendar.current.date(byAdding: .day, value: $0 - dayOfWeek, to: selectedDay) }
        
        for (date, run) in RunViewModel.instance.dateRunDictionary {
            for i in days {
                let day = formatter.string(from: i)
                if date == day {
                    mileage += Double(run.getDistance()) ?? 0
                }
            }
        }
        
        return String(format: "%.2f", mileage)
    }

    private func getMonthMileage() -> String {
        var mileage = 0.0
        
        for (date, run) in RunViewModel.instance.dateRunDictionary {
            for day in 1..<32 {
                let month = CalendarSingleton.shared.getCurrentMonth()
                let year = CalendarSingleton.shared.getCurrentYear()
                let forLoopDate = "\(month)/\(day)/\(year - 2000)"
                if date == forLoopDate {
                    mileage += Double(run.getDistance()) ?? 0
                }
            }
        }
        
        return String(format: "%.2f", mileage)
    }

    private func getYearMileage() -> String {
        var mileage = 0.0
        
        for (date, run) in RunViewModel.instance.dateRunDictionary {
            for month in 1..<13 {
                for day in 1..<32 {
                    let year = CalendarSingleton.shared.getCurrentYear()
                    let forLoopDate = "\(month)/\(day)/\(year - 2000)"
                    if date == forLoopDate {
                        mileage += Double(run.getDistance()) ?? 0
                    }
                }
            }
        }
        
        return String(format: "%.2f", mileage)
    }
}


// MARK: - View setup
extension RunDetailView {
    
    private func setupViews() {
        self.backgroundColor = .clear
        
        addSubview(distanceLabel)
        distanceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        distanceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        distanceLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2).isActive = true
        distanceLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 8).isActive = true
        timeLabel.leftAnchor.constraint(equalTo: distanceLabel.leftAnchor).isActive = true
        timeLabel.widthAnchor.constraint(equalTo: distanceLabel.widthAnchor).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: distanceLabel.heightAnchor).isActive = true
        
        addSubview(paceLabel)
        paceLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8).isActive = true
        paceLabel.leftAnchor.constraint(equalTo: distanceLabel.leftAnchor).isActive = true
        paceLabel.widthAnchor.constraint(equalTo: distanceLabel.widthAnchor).isActive = true
        paceLabel.heightAnchor.constraint(equalTo: distanceLabel.heightAnchor).isActive = true
        
        addSubview(weekMileageLabel)
        weekMileageLabel.topAnchor.constraint(equalTo: distanceLabel.topAnchor).isActive = true
        weekMileageLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        weekMileageLabel.widthAnchor.constraint(equalTo: distanceLabel.widthAnchor).isActive = true
        weekMileageLabel.heightAnchor.constraint(equalTo: distanceLabel.heightAnchor).isActive = true
        
        addSubview(monthMileageLabel)
        monthMileageLabel.topAnchor.constraint(equalTo: weekMileageLabel.bottomAnchor, constant: 8).isActive = true
        monthMileageLabel.rightAnchor.constraint(equalTo: weekMileageLabel.rightAnchor).isActive = true
        monthMileageLabel.widthAnchor.constraint(equalTo: distanceLabel.widthAnchor).isActive = true
        monthMileageLabel.heightAnchor.constraint(equalTo: distanceLabel.heightAnchor).isActive = true
        
        addSubview(yearMileageLabel)
        yearMileageLabel.topAnchor.constraint(equalTo: monthMileageLabel.bottomAnchor, constant: 8).isActive = true
        yearMileageLabel.rightAnchor.constraint(equalTo: weekMileageLabel.rightAnchor).isActive = true
        yearMileageLabel.widthAnchor.constraint(equalTo: distanceLabel.widthAnchor).isActive = true
        yearMileageLabel.heightAnchor.constraint(equalTo: distanceLabel.heightAnchor).isActive = true
    }
}
