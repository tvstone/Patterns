//
//  StartGameViewController.swift
//  WhoWantToBeaMillionaire
//
//  Created by Владислав Тихоненков on 01.11.2021.
//

import UIKit
import RealmSwift

protocol GameDeligate : AnyObject {

    func didEndGame (numberOfQuestion : Int, moneyInPurse : Int, date : String)
}


final class StartGameViewController: UIViewController {
    @IBOutlet weak var newGame: UIButton!
    @IBOutlet weak var results: UIButton!
    @IBOutlet weak var embleme: UIImageView!
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var moneyWin: UILabel!
    @IBOutlet weak var stat: UILabel!
    @IBOutlet weak var dateWin: UILabel!


    //MARK: Cicle of life

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonsAndLayers()
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? GameViewController else {return}
        destination.startGameDeligate = self
    }

    //MARK: Setup layers and buttoms

    func setupButtonsAndLayers () {

        questionNumber.isHidden = true
        moneyWin.isHidden = true
        dateWin.isHidden = true
        stat.isHidden = true

        let buttons = [newGame,results]
        buttons.forEach { buttom in
            buttom?.layer.shadowOpacity = Game.shared.shadowOpacity
            buttom?.layer.shadowColor = Game.shared.shadowColor.cgColor
            buttom?.layer.shadowOffset = Game.shared.shadowOffset
            buttom?.layer.shadowRadius = Game.shared.shadowRadius
        }
        newGame?.configuration?.background.backgroundColor = Game.shared.backgroundAll
        results?.configuration?.background.backgroundColor = Game.shared.backgroundAll
        view.backgroundColor = Game.shared.backgroundAll
        embleme?.layer.cornerRadius = 150
    }
}

extension StartGameViewController : GameDeligate {

    func didEndGame(numberOfQuestion: Int, moneyInPurse: Int, date: String) {
        let statistic = Game.shared

        questionNumber.text = "Верных ответов : \(String(numberOfQuestion))"
        moneyWin.text = "Денег в кошельке : \(String(moneyInPurse)) руб"
        dateWin.text = "Дата : \(statistic.dateFormatter.string(from: Date()))"

        questionNumber.isHidden = false
        moneyWin.isHidden = false
        dateWin.isHidden = false
        stat.isHidden = false

        let singlStat = [date, numberOfQuestion, moneyInPurse] as [Any]

        statistic.allStatisticGame.append(singlStat)
        statistic.moneyInPurse = moneyInPurse
        statistic.numberOfQuestion = numberOfQuestion
        statistic.date = Game.shared.dateFormatter.string(from: Date())

        saveStatisticInRealm(date: statistic.date,
                             number: statistic.numberOfQuestion,
                             money: statistic.moneyInPurse)

    }

    func saveStatisticInRealm (date : String, number : Int, money : Int){


        do {
            let realm = try Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
            print(realm.configuration.fileURL!)
            realm.beginWrite()
            let loadStatRealm = GameRealmStatistic( date: date,
                                                   numberOfQuestion: number,
                                                   moneyInPurse: money)
            realm.add(loadStatRealm, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

}
