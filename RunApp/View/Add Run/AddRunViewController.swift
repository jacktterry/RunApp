//
//  AddRunViewController.swift
//  RunApp
//
//  Created by Jack Terry on 3/20/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import UIKit

protocol AddRunDelegate: class {
    func add(_ run: Run)
}

class AddRunViewController: UIViewController {
    
    // MARK: - Outlets
    private let dateTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "PingFangHK-Regular", size: 18)
        textField.textAlignment = .center
        textField.placeholder = "Date"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        return textField
    }()
    
    private let distanceTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "PingFangHK-Regular", size: 18)
        textField.textAlignment = .center
        textField.placeholder = "Distance"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        return textField
    }()
    
    private let hoursTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "PingFangHK-Regular", size: 18)
        textField.textAlignment = .center
        textField.placeholder = "Hours"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        return textField
    }()
    
    private let minutesTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "PingFangHK-Regular", size: 18)
        textField.textAlignment = .center
        textField.placeholder = "Minutes"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        return textField
    }()
    
    private let secondsTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "PingFangHK-Regular", size: 18)
        textField.textAlignment = .center
        textField.placeholder = "Seconds"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        return textField
    }()
    
    private let addRunButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Run", for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(addRun), for: .touchUpInside)
        button.backgroundColor = .mainBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var datePicker: UIDatePicker?
    
    // MARK: - Delegate to add runs to the view model
    public var addRunDelegate: AddRunDelegate?
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addRunDelegate = RunViewModel.instance
        setupViews()
        configureTextFields()
    }
    
    // MARK: - Method for putting selected date in the dateTextField
    @objc private func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy"
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    // MARK: - Method for dismissing the textField if the view is tapped
    @objc private func dismissTextField(gestureRecognizer: UITapGestureRecognizer) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy"
        dateTextField.text = dateFormatter.string(from: datePicker?.date ?? Date())
        dateTextField.resignFirstResponder()
        view.endEditing(true)
    }
    
    // MARK: - addRunButton's method for adding a new run to Core Data
    @objc private func addRun() {
        let dataController = AddRunDataController(viewController: self)
        guard let date = dateTextField.text, date != "" else { dataController.dateAlert(); return }
        guard let distance = distanceTextField.text, distance != "" else { dataController.distanceAlert(); return }
        if dataController.isNilOrEmpty(textField: hoursTextField) &&
            dataController.isNilOrEmpty(textField: minutesTextField) &&
            dataController.isNilOrEmpty(textField: secondsTextField) {
            dataController.timeAlert()
            return
        }
        var time: String
        let hours = hoursTextField.text ?? ""
        let minutes = minutesTextField.text ?? ""
        var seconds: String
        if let secondsDouble = Double(secondsTextField.text!) {
            seconds = String(format: "%04.1f", secondsDouble)
        } else {
            seconds = "00.0"
        }
    
        if hours != "" {
            time = hours + ":" + minutes + ":" + seconds
        } else {
            time = minutes + ":" + seconds
        }
        
        let pace = dataController.calculatePace(distance: distance, hours: hours, minutes: minutes, seconds: seconds)
        
        let run = Run(distance: distance, time: time, pace: pace, date: date)
        addRunDelegate?.add(run)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - View and outlet configuration
extension AddRunViewController {
    
    private func configureTextFields() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        
        dateTextField.inputView = datePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissTextField(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupViews() {
        self.view.backgroundColor = .secondaryBlue
        
        view.addSubview(distanceTextField)
        distanceTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -75).isActive = true
        distanceTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        distanceTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 100).isActive = true
        distanceTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        view.addSubview(dateTextField)
        dateTextField.bottomAnchor.constraint(equalTo: distanceTextField.topAnchor, constant: -40).isActive = true
        dateTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dateTextField.widthAnchor.constraint(equalTo: distanceTextField.widthAnchor).isActive = true
        dateTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        view.addSubview(hoursTextField)
        hoursTextField.topAnchor.constraint(equalTo: distanceTextField.bottomAnchor, constant: 40).isActive = true
        hoursTextField.leftAnchor.constraint(equalTo: distanceTextField.leftAnchor).isActive = true
        hoursTextField.widthAnchor.constraint(equalToConstant: (view.frame.width - 100) / 3 - 8).isActive = true
        hoursTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        view.addSubview(minutesTextField)
        minutesTextField.topAnchor.constraint(equalTo: hoursTextField.topAnchor).isActive = true
        minutesTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        minutesTextField.leftAnchor.constraint(equalTo: hoursTextField.rightAnchor, constant: 12).isActive = true
        minutesTextField.widthAnchor.constraint(equalTo: hoursTextField.widthAnchor).isActive = true
        minutesTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        view.addSubview(secondsTextField)
        secondsTextField.topAnchor.constraint(equalTo: minutesTextField.topAnchor).isActive = true
        secondsTextField.leftAnchor.constraint(equalTo: minutesTextField.rightAnchor, constant: 12).isActive = true
        secondsTextField.rightAnchor.constraint(equalTo: distanceTextField.rightAnchor).isActive = true
        secondsTextField.bottomAnchor.constraint(equalTo: minutesTextField.bottomAnchor).isActive = true
        
        view.addSubview(addRunButton)
        addRunButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        addRunButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addRunButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        addRunButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
