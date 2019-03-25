//
//  CalendarSingleton.swift
//  RunApp
//
//  Created by Jack Terry on 3/24/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import UIKit

class CalendarSingleton {
    
    static let shared = CalendarSingleton()
    
    // MARK: - Calendar properties
    private let totalDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    private var currentMonthIndex: Int = 0
    private var currentYear: Int = 0
    private var presentMonthIndex: Int = 0
    private var presentYear: Int = 0
    private var today: Int = 0
    private var firstWeek: Int = 0
    
    // MARK: - Configure calendar properties
    private init() {
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        today = Calendar.current.component(.day, from: Date())
        presentMonthIndex = currentMonthIndex
        presentYear = currentYear
        firstWeek = getFirstWeek()
    }
    
    // MARK: - Method for getting the first weekday of the month
    private func getFirstWeek() -> Int {
        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfMonth.weekday)!
        return day == 7 ? 1 : day
    }
    
    public func setCurrentMonth(_ month: Int) {
        self.currentMonthIndex = month
    }
    
    public func getCurrentMonth() -> Int {
        return self.currentMonthIndex
    }
    
    public func setCurrentYear(_ year: Int) {
        self.currentYear = year
    }
    
    public func getCurrentYear() -> Int {
        return self.currentYear
    }
    
    public func numberOfDays() -> Int {
        return totalDaysInMonth[currentMonthIndex - 1] + firstWeek - 1
    }
    
    public func dateCellForItem(in collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCell.reuseIdentifier, for: indexPath) as! DateCell
        
        let calculatedDate = indexPath.row - firstWeek + 2
        cell.dateLabel.text = "\(calculatedDate)"
        if indexPath.item <= firstWeek - 2 {
            cell.setupViews(backgroundColor: .clear)
            cell.isHidden = true
        } else {
            cell.isHidden = false
            if calculatedDate == today && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
                cell.setupViews(backgroundColor: .lightGray)
            } else {
                cell.setupViews(backgroundColor: .clear)
            }
        }
        
        return cell
    }
    
    public func didSelectItem(in collectionView: UICollectionView, at indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DateCell
        cell.backgroundColor = .mainBlue
        let dateString = "\(indexPath.row - firstWeek + 2)"
        let dateIndex = "\(currentMonthIndex)/" + dateString + "/\(currentYear - 2000)"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yy"
        let date = formatter.date(from: dateIndex)!
        NotificationCenter.default.post(name: .didReceiveDateSelected, object: nil, userInfo: [date: date])
        
        guard let run = RunViewModel.instance.dateRunDictionary[dateIndex] else {
            NotificationCenter.default.post(name: .didReceiveRun, object: nil, userInfo: nil)
            return
        }
        
        NotificationCenter.default.post(name: .didReceiveRun, object: nil, userInfo: [run.getDate(): run])
    }
    
    public func didDeselectItem(in collectionView: UICollectionView, at indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DateCell
        if cell.dateLabel.text! == String(today) && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
            cell.backgroundColor = .lightGray
        } else {
            cell.backgroundColor = .clear
        }
    }
}
