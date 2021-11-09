//
//  Question.swift
//  WhoWantToBeaMillionaire
//
//  Created by Владислав Тихоненков on 07.11.2021.
//

import Foundation

struct Question {
    
    var number : String
    var someQuestion : String
    var possibleAnswer : [String]
    var correctAnswer : VariantAnswer
    var price : Int
}

enum VariantAnswer {
    
    case A
    case B
    case C
    case D
}

