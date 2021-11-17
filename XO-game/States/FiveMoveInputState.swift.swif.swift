//
//  FiveMoveInputState.swift.swif.swift
//  XO-game
//
//  Created by Владислав Тихоненков on 16.11.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class FiveMoveInputState: GameState {

    var isCompleted: Bool = false

    let player: Player
    private let markPrototype: MarkView
    private weak var gameViewController: GameViewController?
    private weak var gameboard: Gameboard?
    private weak var gameboardView: GameboardView?


    init(
        player: Player,
        markPrototype: MarkView,
        gameViewController: GameViewController?,
        gameboard: Gameboard?,
        gameboardView: GameboardView?
    ) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
        self.markPrototype = markPrototype
    }

    func begin() {

        self.gameViewController?.computerPlayerLabel.isHidden = true
        self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        self.gameViewController?.fiveStepLabel.isHidden = false
        self.gameViewController?.startFiveStepButton.isHidden = true

        let isFirstPlayerTurn = self.player == .first

        self.gameViewController?.firstPlayerTurnLabel.isHidden = !isFirstPlayerTurn
        self.gameViewController?.secondPlayerTurnLabel.isHidden = isFirstPlayerTurn

        self.gameViewController?.winnerLabel.isHidden = true

        if SelectGame.shared.stopFiveStepFirstPlayer,
           SelectGame.shared.clearGameboardViewFlag
        {
            SelectGame.shared.clearGameboardViewFlag = false
            gameboardView?.clear()
          
        }
        if SelectGame.shared.stopFiveStepFirstPlayer,
           SelectGame.shared.stopFiveStepSecondPlayer {
            self.gameViewController?.startFiveStepButton.isHidden = false
            self.gameViewController?.fiveStepLabel.isHidden = true
        }

    }

    func addMark(at position: GameboardPosition) {
        
        if !SelectGame.shared.stopFiveStepSecondPlayer {
            guard let view = gameboardView, view.canPlaceMarkView(at: position) else { return }

            recordEvent(.playerInput(player: self.player, position: position))

            self.gameboard?.setPlayer(self.player, at: position)
            view.placeMarkView(self.markPrototype.copy(), at: position)

            self.isCompleted = true

        }
    }

}

