//
//  TaskListViewController.swift
//  GoodList
//
//  Created by Nikos Aggelidis on 14/5/23.
//

import UIKit

final class TaskListViewController: UIViewController {
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        
        return cell
    }
}

// MARK: - UI
private extension TaskListViewController {
    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
