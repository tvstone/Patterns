//
//  SecondSubTableViewController.swift
//  CompositPattern
//
//  Created by Владислав Тихоненков on 20.11.2021.
//
import UIKit

final class SecondSubTableViewController: UITableViewController , Task{

    @IBOutlet var secondSubTableView: UITableView!

    private let cellIdentifer = "cellIdentifer"
    var indexTask = Int()
    var tasks: [String] = []
    var subTasks = [[String]]()
    var secondSubTasks = [[[String]]]()
    var titleItems : String? = nil


    func loadTask() -> [String]{

        secondSubTasks = TaskModel.shared.secondSubTasks
        secondSubTasks.append([])
//        if subTasks.count == indexTask  {
//            subTasks.append([])
//        }
        let task : [String] = []//subTasks[indexTask]
        navigationItem.title = titleItems


        return task
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        secondSubTableView.register(UINib(nibName: "UniversalTableViewCell", bundle: nil),
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

            self.secondSubTableView.beginUpdates()
            self.secondSubTableView.insertRows(at: [IndexPath.init(row:
                                            self.subTasks[self.indexTask].count - 1 ,
                                            section: 0)], with: .automatic)
            self.secondSubTableView.endUpdates()
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
        return secondSubTasks.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as?
                 UniversalTableViewCell else {return UITableViewCell()}

       // let sub = subTasks[indexTask][indexPath.row]
        cell.config(tasks: subTasks[indexTask][indexPath.row])

        return cell
    }


//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        indexTask = indexPath.row
//        titleItems = tasks[indexTask]
//
//        performSegue(withIdentifier: "segueFromSecondToThird", sender: Any?.self)
//    }


    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//
//        if segue.identifier == "segueFromSecondToThird",
//           let dst = segue.destination as? SecondSubTableViewController {
//            dst.indexTask = indexTask
//            dst.titleItems = titleItems
//
//        }
//    }

}
