//
//  AddTaskViewController.swift
//  GoodList
//
//  Created by Nikos Aggelidis on 14/5/23.
//

import UIKit

final class AddTaskViewController: UIViewController {
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!
    
    @IBAction func save() {
        guard let priority = Priority(rawValue: prioritySegmentedControl.selectedSegmentIndex),
              let title = taskTitleTextField.text else { return }
        
        let task = Task(title: title, priority: priority)
    }
}
