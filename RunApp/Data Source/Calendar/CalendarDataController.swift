//
//  CalendarDataController.swift
//  RunApp
//
//  Created by Jack Terry on 3/20/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import UIKit

class CalendarDataController: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MonthViewDelegate {
    
    // MARK: - Internal properties
    private var collectionView: UICollectionView?
    
    // MARK: - Lifecycle
    public init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
    }
    
    // MARK: - MonthViewDelegate method
    func didChange(month: Int, year: Int) {
        CalendarSingleton.shared.setCurrentMonth(month + 1)
        CalendarSingleton.shared.setCurrentYear(year)
        
        collectionView?.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CalendarSingleton.shared.numberOfDays()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return CalendarSingleton.shared.dateCellForItem(in: collectionView, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        CalendarSingleton.shared.didSelectItem(in: collectionView, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        CalendarSingleton.shared.didDeselectItem(in: collectionView, at: indexPath)
    }
    
    // MARK: - UICollectionView layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7 - 8
        let height: CGFloat = 40
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
}
