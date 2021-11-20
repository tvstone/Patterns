//
//  SubTaskTableViewController.swift
//  CompositPattern
//
//  Created by Владислав Тихоненков on 20.11.2021.
//

import UIKit

final class SubTaskTableViewController: UITableViewController , Task{

    @IBOutlet weak var subTaskTableView: UITableView!
    
    private let cellIdentifer = "cellIdentifer"

    var indexTask = Int()
    var tasks: [String] = []
    var subTasks = [[String]]()
    var titleItems : String? = nil


    func loadTask() -> [String]{

        subTasks = TaskModel.shared.subTasks
        if subTasks.count == indexTask  {
            subTasks.append([])
        }
        let task = subTasks[indexTask]
        navigationItem.title = titleItems
        

        return task
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        subTaskTableView.register(UINib(nibName: "UniversalTableViewCell", bundle: nil),
                          forCellReuseIdentifier: cellIdentifer)
        navigationItem.title = titleItems
        tasks = loadTask()
        tableView.reloadData()

    }

    @IBAction func newSubTask(_ sender: UIBarButtonItem) {

        let alertController = UIAlertController(title: "Внимание!",
                                                message: "Введите новую задачу .",
                                                preferredStyle: .alert)

        let alertAction = UIAlertAction(title: "OK",
                                        style: .default) { [weak self] action in
            guard let self = self else {return}
            guard let field = alertController.textFields,
                  !field.isEmpty else {return}
            let newText = field[0].text

            self.tasks.append(newText ?? "")
            self.subTasks[self.indexTask].append(newText ?? "")
            TaskModel.shared.subTasks = self.subTasks

            self.subTaskTableView.beginUpdates()
            self.subTaskTableView.insertRows(at: [IndexPath.init(row:
                                            self.subTasks[self.indexTask].count - 1 ,
                                            section: 0)], with: .automatic)
            self.subTaskTableView.endUpdates()
        }

        alertController.addAction(alertAction)
        alertController.addTextField(configurationHandler: nil)
        
        present(alertController, animated: true, completion: nil)
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subTasks[self.indexTask].count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as?
                 UniversalTableViewCell else {return UITableViewCell()}

        cell.config(tasks: self.subTasks[self.indexTask][indexPath.row])

        return cell
    }

}

