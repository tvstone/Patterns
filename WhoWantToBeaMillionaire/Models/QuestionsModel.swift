//
//  QuestionsModel.swift
//  WhoWantToBeaMillionaire
//
//  Created by Владислав Тихоненков on 01.11.2021.
//

import Foundation

protocol OrderOfQuestionsStrategy {

    func selectStrategy (setQuestions : [Question]) -> [Question]
}


final class DirectOrderOfQuestions : OrderOfQuestionsStrategy {
    var  questions = [Question]()

    func selectStrategy(setQuestions: [Question]) -> [Question] {
        if Game.shared.orderOfQuestions == false {
            questions = setQuestions
        }
        return questions
    }

}


final class JumbledOrderOfQuestions : OrderOfQuestionsStrategy {
    var  questions = [Question]()

    func selectStrategy(setQuestions: [Question]) -> [Question] {
        if Game.shared.orderOfQuestions {
            questions = setQuestions.shuffled()
        }
        return questions
    }

}

final class QuestionsModel {

    var questions = [Question]()

    func QuestInit() -> [Question] {
        let one = Question(number : "1",
                           someQuestion: "Какой химический элемент составляет более половины массы тела человека?",
                           possibleAnswer: ["Углерод", "Кальций", "Кислород", "Железо"],
                           correctAnswer: .C,
                           price: 2000)
        questions.append(one)
        let two = Question(number : "2",
                           someQuestion: "Что изображено на заднем плане картины Леонардо да Винчи «Мона Лиза»?",
                           possibleAnswer: ["Драпировка", "Пейзаж", "Город", "Стадо овец"],
                           correctAnswer: .B,
                           price: 3000)
        questions.append(two)
        let three = Question(number : "3",
                             someQuestion: "Под каким названием известна единица с последующими ста нулями?",
                             possibleAnswer: ["Гугол", "Мегатрон", "Гигабит", "Наномоль"],
                             correctAnswer: .A,
                             price: 5000)
        questions.append(three)
        let four = Question(number : "4",
                            someQuestion:
                                "Какое насекомое вызвало короткое замыкание в первых верчиях вычислительных машин, породив термин «компьютерный баг» ?",
                            possibleAnswer: ["Мотылек", "Таракан", "Муха", "Японский хрущик"],
                            correctAnswer: .A,
                            price: 10000)
        questions.append(four)
        let five = Question(number : "5",
            someQuestion: "Сколько кубиков в кубике Рубика?",
                            possibleAnswer: ["20", "22", "24", "26"],
                            correctAnswer: .D,
                            price: 20000)
        questions.append(five)
        let six = Question(number : "6",
                           someQuestion: "Какого цвета крайнее правое кольцо в олимпийской символике?",
                           possibleAnswer: ["Красное", "Синее", "Желтое", "Зеленое"],
                           correctAnswer: .A,
                           price: 50000)
        questions.append(six)
        let sevan = Question(number : "7",
                             someQuestion: "Какую часть тела также называют «атлант»?",
                             possibleAnswer: ["Головной мозг", "Шестая пара ребер", "Шейный позвонок", "Часть плеча"],
                             correctAnswer: .C,
                             price: 100000)
        questions.append(sevan)
        let eight = Question(number : "8",
                             someQuestion: "Что изобразил Юджин Сернан, последний на данный момент побывавший на Луне человек, на ее поверхности?",
                             possibleAnswer: ["Символ мира", "Инициалы дочери", "«Боже, храни Америку»", "«Здесь был Юджин»"],
                             correctAnswer: .B,
                             price: 200000)
        questions.append(eight)
        let nine = Question(number : "9",
                            someQuestion:
                                "Из каких плодов можно получить копру?",
                            possibleAnswer: ["Ананас", "Вишня", "Кокос", "Абрикос"],
                            correctAnswer: .B,
                            price: 260000)
        questions.append(nine)
        let ten = Question(number : "10",
                           someQuestion:
                            "Кем был мужчина, служивший моделью для картины «Американская готика» Гранта Вуда",
                           possibleAnswer: ["Коммивояжером", "Местным шерифом", "Его зубным врачом", "Его мясником"],
                           correctAnswer: .C,
                           price: 350000)
        questions.append(ten)

        return questions

    }


}


