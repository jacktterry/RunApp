//
//  CalendarView.swift
//  RunApp
//
//  Created by Jack Terry on 3/19/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import UIKit

class CalendarView: UIView {
    
    // MARK: - Outlets
    private let calendarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: DateCell.reuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.allowsMultipleSelection = false
        return collectionView
    }()
    
    private let monthView: MonthView = {
        let monthView = MonthView()
        monthView.translatesAutoresizingMaskIntoConstraints = false
        return monthView
    }()
    
    private let weekdayView: WeekdayView = {
        let view = WeekdayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var runViewModel: RunViewModel?
    
    // MARK: - Lifecycle
    public override init(frame: CGRect) {
        super.init(frame: frame)

        initializeCalendar()
    }
    
    public init() {
        self.runViewModel = RunViewModel.instance
        super.init(frame: .zero)
        initializeCalendar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func reloadCollectionView() {
        calendarCollectionView.reloadData()
    }
}

// MARK: - View setup
extension CalendarView {
    
    private func initializeCalendar() {
        let dataController = CalendarDataController(collectionView: calendarCollectionView)
        
        setupView()
        
        calendarCollectionView.delegate = dataController
        calendarCollectionView.dataSource = dataController
        monthView.delegate = dataController
    }
    
    private func setupView() {
        addSubview(monthView)
        monthView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        monthView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        monthView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        monthView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(weekdayView)
        weekdayView.topAnchor.constraint(equalTo: monthView.bottomAnchor).isActive = true
        weekdayView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        weekdayView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        weekdayView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(calendarCollectionView)
        calendarCollectionView.topAnchor.constraint(equalTo: weekdayView.bottomAnchor).isActive = true
        calendarCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        calendarCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        calendarCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

