//
//  TaskListViewController.swift
//  GoodList
//
//  Created by Nikos Aggelidis on 14/5/23.
//

import UIKit
import RxSwift
import RxCocoa

final class TaskListViewController: UIViewController {
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func priorityValueChanged(segmentedControl: UISegmentedControl) {
        let priority = Priority(rawValue: segmentedControl.selectedSegmentIndex - 1)
        filterTasks(by: priority)
    }
    
    private var tasks = BehaviorRelay<[Task]>(value: [])
    private var filteredTasks = [Task]()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController,
              let addTaskViewController = navigationController.viewControllers.first as? AddTaskViewController else {
            fatalError("Controller not found...")
        }
        
        addTaskViewController.taskSubjectObservable
            .subscribe(onNext: { [unowned self] task in
                let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
                var existingTasks = self.tasks.value
                existingTasks.append(task)
                self.tasks.accept(existingTasks)
                
                self.filterTasks(by: priority)
            }).disposed(by: disposeBag)
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
    
    func filterTasks(by priority: Priority?) {
        if priority == nil {
            filteredTasks = tasks.value
        } else {
            tasks.map { tasks in
                return tasks.filter { $0.priority == priority! }
            }.subscribe(onNext: { [weak self] tasks in
                guard let self = self else { return }
                self.filteredTasks = tasks
            }).disposed(by: disposeBag)
        }
    }
}
