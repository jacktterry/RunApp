//
//  RunViewModel.swift
//  RunApp
//
//  Created by Jack Terry on 3/20/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import UIKit
import CoreData

class RunViewModel: AddRunDelegate {
    
    var dateRunDictionary = [String: Run]()
    
    static let instance = RunViewModel()
    
    private init() { }
    
    // MARK: - Receive runs saved in Core Data
    public func fetchData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RunEntity")
        
        do {
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                let distance = data.value(forKey: "distance") as! String
                let time = data.value(forKey: "time") as! String
                let pace = data.value(forKey: "pace") as! String
                let date = data.value(forKey: "date") as! String
                let run = Run(distance: distance, time: time, pace: pace, date: date)
                
                self.dateRunDictionary[run.getDate()] = run
            }
        } catch {
            print("Failed to fetch data")
        }
    }
    
    // MARK: - AddRunDelegate function, used for storing new runs
    public func add(_ run: Run) {
        self.dateRunDictionary[run.getDate()] = run
        saveRun(run)
    }
    
    // MARK: - Function for saving a new run in Core Data
    private func saveRun(_ run: Run) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "RunEntity", in: context)
        let newRun = NSManagedObject(entity: entity!, insertInto: context)
        
        newRun.setValue(run.getDate(), forKey: "date")
        newRun.setValue(run.getPace(), forKey: "pace")
        newRun.setValue(run.getDistance(), forKey: "distance")
        newRun.setValue(run.getTime(), forKey: "time")
        
        do {
            try context.save()
        } catch {
            print("Error saving data")
        }
    }
}
