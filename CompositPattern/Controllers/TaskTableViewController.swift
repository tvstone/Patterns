//
//  TaskTableViewController.swift
//  CompositPattern
//
//  Created by Владислав Тихоненков on 18.11.2021.
//

import UIKit

class TaskTableViewController: UITableViewController, Task {

    @IBOutlet var allTasks: UITableView!
    @IBOutlet weak var plasNewTask: UIBarButtonItem!

    private let cellIdentifer = "cellIdentifer"

    private var indexTask = Int()
    private var loadTasks = LoadTasks()
    private var titleItems : String? = nil


    var tasks: [String] = []


    func loadTask() -> [String] {
        
        tasks = TaskModel.shared.firstTasks
        return tasks
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        allTasks.register(UINib(nibName: "UniversalTableViewCell", bundle: nil),
                          forCellReuseIdentifier: cellIdentifer)
        loadTasks.addTask()
        tasks = loadTask()
        tableView.reloadData()
       
    }


    @IBAction func newTask(_ sender: UIBarButtonItem) {

        let alertController = UIAlertController(title: "Внимание!", message: "Введите новую задачу .", preferredStyle: .alert)

        let alertAction = UIAlertAction(title: "OK",
                                        style: .default) { [weak self] action in
            guard let self = self else {return}

            guard let field = alertController.textFields,
            !field.isEmpty else {return}
            let newText = field[0].text
            self.tasks.append(newText ?? "")
            self.allTasks.beginUpdates()
            self.allTasks.insertRows(at: [IndexPath.init(row: self.tasks.count - 1 , section: 0)], with: .automatic)
            self.allTasks.endUpdates()
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
        return tasks.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as?
                UniversalTableViewCell else {return UITableViewCell()}

        cell.config(tasks: tasks[indexPath.row])
        return cell
    }



    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexTask = indexPath.row
        titleItems = tasks[indexTask]
        
        performSegue(withIdentifier: "segueToSubTask", sender: Any?.self)
    }



    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tasks.remove(at: indexPath.row)
            TaskModel.shared.firstTasks = tasks
            TaskModel.shared.subTasks.remove(at: indexPath.row)
            allTasks.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
            tableView.insertRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.identifier == "segueToSubTask",
           let dst = segue.destination as? SubTaskTableViewController {
            dst.indexTask = indexTask
            dst.titleItems = titleItems
  
        }
    }

}
