//
//  StatisticTableViewController.swift
//  WhoWantToBeaMillionaire
//
//  Created by Владислав Тихоненков on 06.11.2021.
//

import UIKit
import RealmSwift

final class StatisticTableViewController: UITableViewController{

    @IBOutlet var statisticTableView: UITableView!

    private var gameStatistic : Results<GameRealmStatistic>!
    private var date = String()
    private var numberOfQuestion = Int()
    private var moneyInPurse = Int()
    private var statisticArray = [Statistic]()
    private let reuseIdentifier = "cellOfGameStatistic"



    override func viewDidLoad() {
        super.viewDidLoad()

        statisticTableView.backgroundColor = Game.shared.backgroundAll

        self.tableView.register(UINib(nibName: "StatisticTableCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)

        do {
            let realm = try Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))

            gameStatistic = realm.objects(GameRealmStatistic.self)
            gameStatistic.forEach { gameStat in
                date = gameStat.date
                numberOfQuestion = gameStat.numberOfQuestion
                moneyInPurse = gameStat.moneyInPurse
                let stat = Statistic(date: date,
                                     numberOfQuestion: numberOfQuestion,
                                     moneyInPurse: moneyInPurse)

                statisticArray.append(stat)
            }
            statisticArray = statisticArray.sorted{ $0.date > $1.date}

        } catch {
            print(error)
        }

    }

    // MARK: - Table view data source


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statisticArray.count

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
                as? StatisticTableCell else {return UITableViewCell()}

       cell.config(singleStatistic: statisticArray[indexPath.row])

        return cell
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return "Вопросы         Кошелек                            Дата"
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.backgroundView?.backgroundColor = Game.shared.backgroundAll
        header.textLabel?.textColor = .white
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)

    }
}
