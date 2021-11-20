//
//  SecondTableViewController.swift
//  CompositPattern
//
//  Created by Владислав Тихоненков on 18.11.2021.
//

import UIKit

private class SecondTableViewController: UITableViewController {

    @IBOutlet var secondTableView: UITableView!

    private let cellIdentifer = "cellIdentiferSecond"
    private var tasks = [Task]()
    private let taskModel = TaskModel()

    override func viewDidLoad() {
        super.viewDidLoad()

//        socondTableView.register(UINib(nibName: "SecondUniversalTableViewCell", bundle: nil),
//                          forCellReuseIdentifier: cellIdentifer)

        secondTableView.register(UINib(nibName: "SecondUniversalTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifer)
        tasks = taskModel.loadAppartamentRenovation()
        print(tasks)
     
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
                SecondUniversalTableViewCell else {return UITableViewCell()}

        cell.config(tasks: tasks[indexPath.row])


        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
