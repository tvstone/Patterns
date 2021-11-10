//
//  GameViewController.swift
//  WhoWantToBeaMillionaire
//
//  Created by Владислав Тихоненков on 01.11.2021.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var backViewForText: UIView!
    @IBOutlet weak var textViewQuestion: UITextView!
    @IBOutlet weak var answerA: UIButton!
    @IBOutlet weak var answerB: UIButton!
    @IBOutlet weak var answerC: UIButton!
    @IBOutlet weak var answerD: UIButton!
    @IBOutlet weak var nexButton: UIButton!
    @IBOutlet weak var priceOfQuestion: UILabel!
    @IBOutlet weak var purse: UIButton!
    @IBOutlet weak var helpHoll: UIButton!
    @IBOutlet weak var friedColl: UIButton!
    @IBOutlet weak var fiftyFifty: UIButton!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var countOfQuestion: UILabel!

    weak var startGameDeligate : StartGameViewController?

    private var questions = StartGameViewController()
    private var questArr = [Question]()
    private var clicA = false
    private var clicB = false
    private var clicC = false
    private var clicD = false
    private var bingo = false
    private var numderOfQuestion = 0 {
        didSet{
            countOfQuestion.text = String(numderOfQuestion + 1)
        }
    }
    private var myAnswerVariant : VariantAnswer = .A
    private var price = 0
    private var countTimer = 60
    private var timer = Timer()
    private var lineStrategy : OrderOfQuestionsStrategy = DirectOrderOfQuestions()
    private var jampedStrategi : OrderOfQuestionsStrategy = JumbledOrderOfQuestions()
 //   private let newQuestionsInRealm = QuestionsRealm()

    //MARK: Life cycle

    override func viewDidLoad() {

        super.viewDidLoad()
        questArr = questions.loadAllQuestions()


        if Game.shared.orderOfQuestions {
            questArr = jampedStrategi.selectStrategy(setQuestions: questArr)
        } else {
            questArr = lineStrategy.selectStrategy(setQuestions: questArr)
        }
        clearAllLayers()
    }

    override func viewWillAppear(_ animated: Bool) {

        clearAllLayers()
        newQuestion(number: numderOfQuestion)

    }

    
    //MARK: New question

    func newQuestion(number : Int) {

        textViewQuestion.text = questArr[number].someQuestion

        for (index, answer) in questArr[number].possibleAnswer.enumerated() {
            switch index {
            case 0 :
                answerA.configuration?.title = answer
            case 1 :
                answerB.configuration?.title = answer
            case 2 :
                answerC.configuration?.title = answer
            case 3 :
                answerD.configuration?.title = answer
            default:
                break
            }
        }

    }


    //MARK: What happend for clic buttom

    func clic() {

        let onlyClic = [clicA, clicB, clicC, clicD]
        let buttons = [answerA, answerB, answerC, answerD]

        for (index, clic) in onlyClic.enumerated() {
            if clic == true {
                let clicIndex = index
                switch buttons[clicIndex] {
                case answerA :
                    answerA.configuration?.background.backgroundColor = .orange
                    answerB.configuration?.background.backgroundColor = #colorLiteral(red: 0.02291891724, green: 0.04782503098, blue: 0.291015774, alpha: 1)
                    answerC.configuration?.background.backgroundColor = #colorLiteral(red: 0.02291891724, green: 0.04782503098, blue: 0.291015774, alpha: 1)
                    answerD.configuration?.background.backgroundColor = #colorLiteral(red: 0.02291891724, green: 0.04782503098, blue: 0.291015774, alpha: 1)
                    myAnswerVariant = .A
                    if correctAnswer() {
                        answerA.configuration?.background.backgroundColor =
                            .systemGreen
                        timer.invalidate()
                        
                    }

                case answerB :
                    answerA.configuration?.background.backgroundColor = #colorLiteral(red: 0.02291891724, green: 0.04782503098, blue: 0.291015774, alpha: 1)
                    answerB.configuration?.background.backgroundColor = .orange
                    answerC.configuration?.background.backgroundColor = #colorLiteral(red: 0.02291891724, green: 0.04782503098, blue: 0.291015774, alpha: 1)
                    answerD.configuration?.background.backgroundColor = #colorLiteral(red: 0.02291891724, green: 0.04782503098, blue: 0.291015774, alpha: 1)
                    myAnswerVariant = .B
                    if correctAnswer() {
                        answerB.configuration?.background.backgroundColor =
                            .systemGreen
                        timer.invalidate()
                    }
                case answerC :
                    answerA.configuration?.background.backgroundColor = #colorLiteral(red: 0.02291891724, green: 0.04782503098, blue: 0.291015774, alpha: 1)
                    answerB.configuration?.background.backgroundColor = #colorLiteral(red: 0.02291891724, green: 0.04782503098, blue: 0.291015774, alpha: 1)
                    answerC.configuration?.background.backgroundColor = .orange
                    answerD.configuration?.background.backgroundColor = #colorLiteral(red: 0.02291891724, green: 0.04782503098, blue: 0.291015774, alpha: 1)
                    myAnswerVariant = .C
                    if correctAnswer() {
                        answerC.configuration?.background.backgroundColor =
                            .systemGreen
                        timer.invalidate()
                    }

                case answerD :
                    answerA.configuration?.background.backgroundColor = #colorLiteral(red: 0.02291891724, green: 0.04782503098, blue: 0.291015774, alpha: 1)
                    answerB.configuration?.background.backgroundColor = #colorLiteral(red: 0.02291891724, green: 0.04782503098, blue: 0.291015774, alpha: 1)
                    answerC.configuration?.background.backgroundColor = #colorLiteral(red: 0.02291891724, green: 0.04782503098, blue: 0.291015774, alpha: 1)
                    answerD.configuration?.background.backgroundColor = .orange
                    myAnswerVariant = .D
                    if correctAnswer() {
                        answerD.configuration?.background.backgroundColor =
                            .systemGreen
                        timer.invalidate()
                    }
                default:
                    break
                }

            }
        }
    }

    //MARK: Correct answer for every question

    func correctAnswer() -> Bool {

        if myAnswerVariant == questArr[numderOfQuestion].correctAnswer {
            textViewQuestion.backgroundColor = .systemGreen
            bingo = true
            price = price + questArr[numderOfQuestion].price
            purse.configuration?.title = "   В кошельке находится \n               \(price) руб    \n Хотите забрать выигрыш?"
        } else {

            let alertController = UIAlertController(title: "ВНИМАНИЕ !!!",
                                                    message: "Ответ не верный.  Игра окончена.",
                                                    preferredStyle: .alert)
            let alertOkAction = UIAlertAction(title: "OK",
                                              style: .destructive,
                                              handler: { [weak self] action in
                guard let self = self else { return}
                self.startGameDeligate?.didEndGame(numberOfQuestion: self.numderOfQuestion,
                                                   moneyInPurse: self.price,
                                                   date: Game.shared.dateFormatter.string(from: Date()))
                self.dismiss(animated: true, completion: nil)
                self.numderOfQuestion = 1
            })
            alertController.addAction(alertOkAction)

            present(alertController, animated: false) { [weak self] in
                guard let self = self else {return}
                self.textViewQuestion.backgroundColor = .systemRed
                self.bingo = false
                self.timer.invalidate()
            }
        }
        return bingo
    }


    //MARK: Clear all layers and styles

    func clearAllLayers() {

        let buttons = [purse, helpHoll, friedColl, fiftyFifty, nexButton]

        buttons.forEach { buttom in
            buttom?.layer.shadowOpacity = Game.shared.shadowOpacity
            buttom?.layer.shadowColor = Game.shared.shadowColor.cgColor
            buttom?.layer.shadowOffset = Game.shared.shadowOffset
            buttom?.layer.shadowRadius = Game.shared.shadowRadius
        }
        view.backgroundColor = Game.shared.backgroundAll
        answerA.configuration?.background.backgroundColor = Game.shared.backgroundAll
        answerB.configuration?.background.backgroundColor = Game.shared.backgroundAll
        answerC.configuration?.background.backgroundColor = Game.shared.backgroundAll
        answerD.configuration?.background.backgroundColor = Game.shared.backgroundAll
        textViewQuestion.backgroundColor = .systemTeal
        textViewQuestion.layer.cornerRadius = 10
        backViewForText.layer.cornerRadius = 10
        bingo = false
        nexButton.configuration?.title = "  Следующий вопрос "
        priceOfQuestion.text = "Цена вопроса - " +
        String(questArr[numderOfQuestion].price) +
        " руб"
        timer.invalidate()
        timer  = Timer.scheduledTimer(timeInterval: 1,
                                      target: self,
                                      selector: #selector(updateTimer),
                                      userInfo: nil,
                                      repeats: true)
    }

    @objc func updateTimer() {
        if countTimer > 0 {
            countTimer -= 1
            countDownLabel.text = String(countTimer)
        } else{
            let alertController = UIAlertController(title: "ВНИМАНИЕ !!!",
                                                    message: "Закончилось время.  Игра окончена.",
                                                    preferredStyle: .alert)
            let alertOkAction = UIAlertAction(title: "OK",
                                              style: .destructive,
                                              handler: {[weak self] action in
                guard let self = self else { return}
                self.startGameDeligate?.didEndGame(numberOfQuestion: self.numderOfQuestion,
                                                   moneyInPurse: self.price,
                                                   date: Game.shared.dateFormatter.string(from: Date()))
                self.dismiss(animated: true, completion: nil)
                self.numderOfQuestion = 1
            })
            alertController.addAction(alertOkAction)
            present(alertController, animated: false) { [weak self] in
                guard let self = self else {return}
                self.textViewQuestion.backgroundColor = .systemRed
                self.bingo = false
                self.timer.invalidate()
            }
        }
    }


    //MARK: ABactions fo all buttoms

    @IBAction func buttonA(_ sender: Any) {

          if bingo != true {
            clicA = true
            clicB = false
            clicC = false
            clicD = false
            clic()
        }
    }

    @IBAction func buttonB(_ sender: Any) {

          if bingo != true {
            clicB = true
            clicA = false
            clicC = false
            clicD = false
            clic()
        }

    }

    @IBAction func buttonC(_ sender: Any) {

          if bingo != true {
            clicC = true
            clicA = false
            clicB = false
            clicD = false
            clic()
        }
    }

    @IBAction func buttonD(_ sender: Any) {
        if bingo != true {
            clicD = true
            clicA = false
            clicB = false
            clicC = false
            clic()
        }
    }

    @IBAction func nexQuestion(_ sender: Any) {

        numderOfQuestion += 1
        if numderOfQuestion < 10,
           bingo
        {
            countTimer = 60
            timer.invalidate()
            viewWillAppear(true)
        } else {
            if bingo  {
                let alertController = UIAlertController(title: "ПОЗДРАВЛЯЕМ !!!",
                                                        message: "Вы ответили на 10 вопросов и заработали \(self.price) рублей",
                                                        preferredStyle: .alert)
                let alertOkAction = UIAlertAction(title: "OK",
                                                  style: .default,
                                                  handler: { [weak self] action in
                    guard let self = self else { return}
                    self.startGameDeligate?.didEndGame(numberOfQuestion: 10,
                                                       moneyInPurse: self.price,
                                                       date: Game.shared.dateFormatter.string(from: Date()))
                    self.dismiss(animated: true, completion: nil)
                })
                alertController.addAction(alertOkAction)
                present(alertController, animated: true)
                numderOfQuestion = 0
                timer.invalidate()

            } else {
                numderOfQuestion -= 1
            }
        }
    }

    
    @IBAction func fifty(_ sender: Any) {


    }
}

