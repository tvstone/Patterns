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
    @IBOutlet weak var setups: UIButton!

    private var questions = QuestionsModel()
    private var questArr = [Question]()
    private let newQuestionsInRealm = QuestionsRealm()
    private var loadQuestions : Results<QuestionsRealm>!


    //MARK: Cicle of life

    override func viewDidLoad() {
        super.viewDidLoad()

        questArr = loadAllQuestions()
        setupButtonsAndLayers()
        print(questArr)
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

        let buttons = [newGame, results, setups]
        buttons.forEach { buttom in
            buttom?.layer.shadowOpacity = Game.shared.shadowOpacity
            buttom?.layer.shadowColor = Game.shared.shadowColor.cgColor
            buttom?.layer.shadowOffset = Game.shared.shadowOffset
            buttom?.layer.shadowRadius = Game.shared.shadowRadius
            buttom?.configuration?.background.backgroundColor = Game.shared.backgroundAll
        }
        view.backgroundColor = Game.shared.backgroundAll
        embleme?.layer.cornerRadius = 150
    }

    func loadAllQuestions() -> [Question] {

        do {
            let realm = try Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
            print(realm.configuration.fileURL!)
            loadQuestions = realm.objects(QuestionsRealm.self)
        } catch {
            print(error)
        }
        if loadQuestions.isEmpty {
            questArr = questions.QuestInit()
            questArr.forEach { newQuews in
                newQuestionsInRealm.saveQuestionsToRealm(newQuestion: newQuews)
                Game.shared.countQuestions = newQuews.number
            }
        } else {
//            questArr = loadAllQuestionsFromRealm()

            var current : VariantAnswer = .A
        loadQuestions.forEach { question in
            let number = question.count
            let qust = question.question
            let a = question.answerA
            let b = question.answerB
            let c = question.answerC
            let d = question.answerD
            switch question.currentAnswer {
            case "0":
                current = .A
            case "1":
                current = .B
            case "2":
                current = .C
            case "3":
                current = .D

            default:
                break
            }
            let price = question.costOfQuestion
            let answer = [a,b,c,d]
            let newQuestion = Question(number: number,
                                       someQuestion: qust,
                                       possibleAnswer: answer,
                                       correctAnswer: current,
                                       price: Int(price) ?? 0)
            questArr.append(newQuestion)

        }

        }
        return questArr
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
