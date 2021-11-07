//
//  QuestionsModel.swift
//  WhoWantToBeaMillionaire
//
//  Created by Владислав Тихоненков on 01.11.2021.
//

import Foundation

final class QuestionsModel {

    var questions = [Question]()
    var variant = VariantAnswer.self

    func QuestInit() -> [Question] {
        let one = Question(someQuestion: "Какой химический элемент составляет более половины массы тела человека?",
                            possibleAnswer: ["Углерод", "Кальций", "Кислород", "Железо"],
                            correctAnswer: .C,
                            price: 2000)
        questions.append(one)
        let two = Question(someQuestion: "Что изображено на заднем плане картины Леонардо да Винчи «Мона Лиза»?",
                            possibleAnswer: ["Драпировка", "Пейзаж", "Город", "Стадо овец"],
                           correctAnswer: .B,
                           price: 3000)
        questions.append(two)
        let three = Question(someQuestion: "Под каким названием известна единица с последующими ста нулями?",
                            possibleAnswer: ["Гугол", "Мегатрон", "Гигабит", "Наномоль"],
                            correctAnswer: .A,
                            price: 5000)
        questions.append(three)
        let four = Question(someQuestion:
                            "Какое насекомое вызвало короткое замыкание в первых верчиях вычислительных машин, породив термин «компьютерный баг» ?",
                           possibleAnswer: ["Мотылек", "Таракан", "Муха", "Японский хрущик"],
                           correctAnswer: .A,
                            price: 10000)
        questions.append(four)
        let five = Question(someQuestion: "Сколько кубиков в кубике Рубика?",
                            possibleAnswer: ["20", "22", "24", "26"],
                             correctAnswer: .D,
                            price: 20000)
        questions.append(five)
        let six = Question(someQuestion: "Какого цвета крайнее правое кольцо в олимпийской символике?",
                            possibleAnswer: ["Красное", "Синее", "Желтое", "Зеленое"],
                            correctAnswer: .A,
                           price: 50000)
        questions.append(six)
        let sevan = Question(someQuestion: "Какую часть тела также называют «атлант»?",
                            possibleAnswer: ["Головной мозг", "Шестая пара ребер", "Шейный позвонок", "Часть плеча"],
                           correctAnswer: .C,
                             price: 100000)
        questions.append(sevan)
        let eight = Question(someQuestion: "Что изобразил Юджин Сернан, последний на данный момент побывавший на Луне человек, на ее поверхности?",
                            possibleAnswer: ["Символ мира", "Инициалы дочери", "«Боже, храни Америку»", "«Здесь был Юджин»"],
                             correctAnswer: .B,
                             price: 200000)
        questions.append(eight)
        let nine = Question(someQuestion:
                                "Из каких плодов можно получить копру?",
                             possibleAnswer: ["Ананас", "Вишня", "Кокос", "Абрикос"],
                             correctAnswer: .B,
                            price: 260000)
        questions.append(nine)
        let ten = Question(someQuestion:
                            "Кем был мужчина, послуживший моделью для известной картины «Американская готика» Гранта Вуда?",
                           possibleAnswer: ["Коммивояжером", "Местным шерифом", "Его зубным врачом", "Его мясником"],
                           correctAnswer: .C,
                           price: 350000)
        questions.append(ten)

        return questions
     
    }


}


