//
//  SelectGame.swift
//  XO-game
//
//  Created by Владислав Тихоненков on 17.11.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

final class SelectGame {


    enum SelectedGame {
        case twoPlayers
        case playerVScomputer
        case fiveMoveTwoPlayers
    }

    static var shared = SelectGame()
    var game : SelectedGame = .twoPlayers
    var stopFiveStepFirstPlayer = false
    var stopFiveStepSecondPlayer = true
    var clearGameboardViewFlag = true
    var allCommandsFiveSteps : [Commands] = []

   
}
