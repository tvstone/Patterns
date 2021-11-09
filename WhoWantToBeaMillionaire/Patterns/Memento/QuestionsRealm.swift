//
//  QuestionsRealm.swift
//  WhoWantToBeaMillionaire
//
//  Created by Владислав Тихоненков on 08.11.2021.
//

import Foundation
import RealmSwift

final class QuestionsRealm : Object {

    @objc dynamic var count = String()
    @objc dynamic var question = String()
    @objc dynamic var answerA = String()
    @objc dynamic var answerB = String()
    @objc dynamic var answerC = String()
    @objc dynamic var answerD = String()
    @objc dynamic var currentAnswer = String()
    @objc dynamic var costOfQuestion = String()

    convenience init(count : String, question : String, answerA : String, answerB : String,
                     answerC : String, answerD : String,
                     currentAnswer : String, costOfQuestion : String) {
        self.init()
        self.count = count
        self.question = question
        self.answerA = answerA
        self.answerB = answerB
        self.answerC = answerC
        self.answerD = answerD
        self.currentAnswer = currentAnswer
        self.costOfQuestion = costOfQuestion
    }

    override class func primaryKey () -> String?{
        return "count"
    }



    func saveQuestionsToRealm(newQuestion question : Question ) {

        var answer = 0

            switch question.correctAnswer {
            case .A :
                answer = 0
            case .B :
                answer = 1
            case .C :
                answer = 2
            case .D :
                answer = 3

            }
        do {
            let realm = try Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
            realm.beginWrite()
            let loadQuestion = QuestionsRealm(count : question.number,
                                              question: question.someQuestion,
                                              answerA: question.possibleAnswer[0],
                                              answerB: question.possibleAnswer[1],
                                              answerC: question.possibleAnswer[2],
                                              answerD: question.possibleAnswer[3],
                                              currentAnswer: String(answer),
                                              costOfQuestion: String(question.price))
            realm.add(loadQuestion, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }


    func loadQuestionsFromRealm() {



    }


}
