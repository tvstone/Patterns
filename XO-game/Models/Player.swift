//
//  Player.swift
//  XO-game
//
//  Created by Evgeny Kireev on 26/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation


private var stepsFirstPlayer = 5
private var stepsSecondPlayer = 5

public enum Player: CaseIterable {
    case first
    case second
    case computer

    var next: Player {

        switch self {
        case .first:
            switch SelectGame.shared.game {
            case .twoPlayers :
                return .second
            case .playerVScomputer:
                return .computer
            case .fiveMoveTwoPlayers:
                if stepsFirstPlayer != 1 {
                    stepsFirstPlayer -= 1
                    return .first
                } else {
                    stepsFirstPlayer = 5
                    SelectGame.shared.stopFiveStepFirstPlayer = true
                    SelectGame.shared.stopFiveStepSecondPlayer = false
                    return .second }
            }
        case .second:
            switch SelectGame.shared.game {
            case .twoPlayers :
                return .first
            case .playerVScomputer:
                return .computer
            case .fiveMoveTwoPlayers:

                if stepsSecondPlayer != 1 {
                    stepsSecondPlayer -= 1
                    return .second
                } else {
                    stepsSecondPlayer = 5
                    SelectGame.shared.stopFiveStepSecondPlayer = true
                    
                    return .second}

            }

        case .computer: return .first

        }
    }
    
    var markViewPrototype: MarkView {
        switch self {
        case .first:return XView()
        case .second: return OView()
        case .computer : return OView()
        }
    }
}


//final class SelectGame {
//
//
//    enum SelectedGame {
//        case twoPlayers
//        case playerVScomputer
//        case fiveMoveTwoPlayers
//    }
//    
//    static var shared = SelectGame()
//    var game : SelectedGame = .twoPlayers
//    var stopFiveStepFirstPlayer = false
//    var stopFiveStepSecondPlayer = true
//    var clearGameboardViewFlag = true
//}
