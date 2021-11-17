//
//  ComputerInputState.swift
//  XO-game
//
//  Created by Владислав Тихоненков on 14.11.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

//import UIKit
import Foundation
class ComputerInputState: GameState {


    var isCompleted: Bool = false

    let player : Player
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

        self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        self.gameViewController?.fiveStepLabel.isHidden = true
        self.gameViewController?.startFiveStepButton.isHidden = true
        switch player {
        case .first :
            self.gameViewController?.firstPlayerTurnLabel.isHidden = false
            self.gameViewController?.computerPlayerLabel.isHidden = false
        case .second :
            self.gameViewController?.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.computerPlayerLabel.isHidden = false
        case .computer :
            self.gameViewController?.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.computerPlayerLabel.isHidden = false

            let position = bestPositionForComputer()
            guard let view = gameboardView, view.canPlaceMarkView(at: position) else { return }
            recordEvent(.playerInput(player: self.player, position: position))
            self.gameboard?.setPlayer(self.player, at: position)
            view.placeMarkView(self.markPrototype.copy(), at: position)
            self.isCompleted = true
            gameViewController?.viewDidLoad()

        }
        self.gameViewController?.winnerLabel.isHidden = true
    }

    func addMark(at position: GameboardPosition) {

            guard let view = gameboardView, view.canPlaceMarkView(at: position) else { return }

            recordEvent(.playerInput(player: self.player, position: position))

            self.gameboard?.setPlayer(self.player, at: position)
            view.placeMarkView(self.markPrototype.copy(), at: position)

            self.isCompleted = true

    }


    func bestPositionForComputer() -> GameboardPosition {
        var clearPosition = [GameboardPosition]()
        for colomn in 0 ..< GameboardSize.columns{
            for row in 0 ..< GameboardSize.rows {
                let position = GameboardPosition(column: colomn, row: row)
                if let view = gameboardView, view.canPlaceMarkView(at: position) {
                    clearPosition.append(position)}
            }
        }
        let randomPosition = clearPosition.randomElement() ?? GameboardPosition(column: 0, row: 0)
        return randomPosition

    }




}
