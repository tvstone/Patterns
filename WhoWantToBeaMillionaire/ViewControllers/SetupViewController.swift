//
//  SetupViewController.swift
//  WhoWantToBeaMillionaire
//
//  Created by Владислав Тихоненков on 08.11.2021.
//

import UIKit
import SwiftUI

class SetupViewController: UIViewController {

    @IBOutlet weak var change: UISwitch!
    private var questionsRealm = QuestionsRealm()

    override func viewDidLoad() {
        super.viewDidLoad()


    }


    @IBAction func swichOnOff(_ sender: UISwitch) {

        if sender.isOn {
            Game.shared.orderOfQuestions = true
            Game.shared.swichOnJampAllQuestions = true
        } else {
            Game.shared.orderOfQuestions = false
            Game.shared.swichOnJampAllQuestions = false
        }
        print(Game.shared.orderOfQuestions)
    }


    override func viewWillAppear(_ animated: Bool) {
        if Game.shared.swichOnJampAllQuestions {
            change.isOn = true
        } else {
            change.isOn = false
        }
    }
    @IBAction func addNew(_ sender: UISwitch) {

        if sender.isOn {

            let alertController = UIAlertController(title: "Добавить вопрос.",
                                                    message: "Введите новый вопрос, варианты ответа в систему и его стоимость.",
                                                    preferredStyle: .alert)
            let alertOkAction = UIAlertAction(title: "Ввод",
                                              style: .default) {  alert in
                var possibeAnsver = [String]()
                var rightAnswer : VariantAnswer = .A


                guard let fields = alertController.textFields,
                      fields.count == 7 else {return}

                guard let newQuestion = fields[0].text,
                      !newQuestion.isEmpty else {return}
                guard let answerFirst = fields[1].text,
                      !answerFirst.isEmpty else {return}
                possibeAnsver.append(answerFirst)
                guard let answerSecond = fields[2].text,
                      !answerSecond.isEmpty else {return}
                possibeAnsver.append(answerSecond)
                guard let answerThree = fields[3].text,
                      !answerThree.isEmpty else {return}
                possibeAnsver.append(answerThree)
                guard let answerFour = fields[4].text,
                      !answerFour.isEmpty else {return}
                possibeAnsver.append(answerFour)
                guard let currentAnswer = fields[5].text,
                      !currentAnswer.isEmpty else {return}
                switch currentAnswer {
                case "1":
                    rightAnswer = .A
                case "2":
                    rightAnswer = .B
                case "3":
                    rightAnswer = .C
                case "4":
                    rightAnswer = .D
                default :
                    fields[5].placeholder = "Введите правильный вариант"
                }

                guard let cost = fields[6].text,
                      !cost.isEmpty,
                      let costInt = Int(cost)
                else {return}

                guard var countOfQuestions = Int(Game.shared.countQuestions) else {return}
                countOfQuestions += 1
                let newQuest = Question(number : String(countOfQuestions),
                                        someQuestion: newQuestion,
                                        possibleAnswer: possibeAnsver,
                                        correctAnswer: rightAnswer,
                                        price: costInt)
                self.questionsRealm.saveQuestionsToRealm(newQuestion: newQuest)
                sender.isOn = false
                Game.shared.countQuestions = String(countOfQuestions)

            }
            let alertCancelAction = UIAlertAction(title: "Отмена",
                                                  style: .default){ alert in
                sender.isOn = false
            }

            alertController.addTextField { question in
                question.placeholder = " Введите ваш вопрос."
                question.font = UIFont(name: "Didot", size: 18)

            }
            alertController.addTextField { answerFirst in
                answerFirst.placeholder = " Первый вариант ответа"
                answerFirst.textColor = .blue
                answerFirst.font = UIFont(name: "Didot", size: 18)
            }
            alertController.addTextField { answerSecond in
                answerSecond.placeholder = " Второй вариант ответа"
                answerSecond.textColor = .blue

                answerSecond.font = UIFont(name: "Didot", size: 18)
            }
            alertController.addTextField { answerThree in
                answerThree.placeholder = " Третий вариант ответа"
                answerThree.textColor = .blue

                answerThree.font = UIFont(name: "Didot", size: 18)
            }
            alertController.addTextField { answerFour in
                answerFour.placeholder = " Четвертый вариант ответа"
                answerFour.textColor = .blue

                answerFour.font = UIFont(name: "Didot", size: 18)
            }
            alertController.addTextField { currentAnswer in
                currentAnswer.placeholder = " Номер правильного ответа"
                currentAnswer.textColor = .systemPink

                currentAnswer.font = UIFont(name: "Didot", size: 18)
            }
            alertController.addTextField { currentAnswer in
                currentAnswer.placeholder = " Цена вопроса"
                currentAnswer.textColor = .systemPink

                currentAnswer.font = UIFont(name: "Didot", size: 18)
            }




            alertController.addAction(alertOkAction)
            alertController.addAction(alertCancelAction)

            present(alertController, animated: true)




        }



    }



}
