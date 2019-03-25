//
//  ViewController.swift
//  RunApp
//
//  Created by Jack Terry on 3/19/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    // MARK: - Outlets
    private var runDetailView: RunDetailView = {
        let view = RunDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var calendarView: CalendarView?

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar(title: "Calendar")
        setupViews()
        RunViewModel.instance.fetchData()
    }
}

// MARK: - View setup
extension CalendarViewController {
    
    private func setupViews() {
        self.view.backgroundColor = .secondaryBlue
        
        calendarView = CalendarView()
        calendarView?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(calendarView!)
        calendarView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        calendarView?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        calendarView?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        calendarView?.heightAnchor.constraint(equalToConstant: 365).isActive = true
        
        view.addSubview(separatorView)
        separatorView.topAnchor.constraint(equalTo: (calendarView?.bottomAnchor)!).isActive = true
        separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        view.addSubview(runDetailView)
        runDetailView.topAnchor.constraint(equalTo: separatorView.bottomAnchor).isActive = true
        runDetailView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        runDetailView.widthAnchor.constraint(equalToConstant: view.frame.width - 12).isActive = true
        runDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupNavigationBar(title: String) {
        self.navigationController?.navigationBar.barTintColor = .mainBlue
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isOpaque = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        self.navigationItem.title = title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toAddRunViewController))
    }
    
    @objc private func toAddRunViewController() {
        let addRunViewController = AddRunViewController()
        self.navigationController?.pushViewController(addRunViewController, animated: true)
    }
}

