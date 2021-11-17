//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet weak var computerPlayerLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    @IBOutlet weak var selectGame: UISegmentedControl!
    @IBOutlet weak var fiveStepLabel: UILabel!
    @IBOutlet weak var startFiveStepButton: UIButton!

    
    private lazy var referee = Referee(gameboard: self.gameboard)
    private var gameboard = Gameboard()
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch SelectGame.shared.game {
        case .twoPlayers:
            self.goToFirstState()
        case .playerVScomputer:
            self.goToNextState()
        case .fiveMoveTwoPlayers:
                self.goToNextState()
        }

        self.gameboardView.onSelectPosition = { [unowned self] position in

            self.currentState.addMark(at: position)

            if self.currentState.isCompleted{
                self.goToNextState()
            }
            if SelectGame.shared.game != .fiveMoveTwoPlayers  {
            if let winner = self.referee.determineWinner() {
                self.currentState = WinnerState(winnerPlayer: winner,
                                                gameViewController: self)
                return
            }
            }

        }
    }

    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        self.gameboard.clear()
        self.gameboardView.clear()
        self.goToFirstState()
        SelectGame.shared.stopFiveStepFirstPlayer = false
        SelectGame.shared.stopFiveStepSecondPlayer = false
        SelectGame.shared.clearGameboardViewFlag = true
        
        recordEvent(.restartGame)
        SelectGame.shared.allCommandsFiveSteps = []
        startFiveStepButton.isHidden = true
   
       
    }

    @IBAction func selectGames(_ sender: UISegmentedControl) {

        switch sender.selectedSegmentIndex {
        case 0:
            SelectGame.shared.game = .twoPlayers
        case 1:
            SelectGame.shared.game = .playerVScomputer
        case 2:
            SelectGame.shared.game = .fiveMoveTwoPlayers
            AnalyticsManager.shared.commands = []
        default:
            return
        }

        self.winnerLabel.isHidden = true
        restartButtonTapped(UIButton.init())
    }


    @IBAction func startFiveStepsGame(_ sender: UIButton) {

        self.gameboardView.clear()
        self.gameboard.clear()
        var positionsFirstPlayer = [GameboardPosition]()
        var positionsSecondPlayer = [GameboardPosition]()
        let allCommands = SelectGame.shared.allCommandsFiveSteps

        allCommands.forEach { command in
            if command.player == .first {
                positionsFirstPlayer.append(command.position)

            } else {
                positionsSecondPlayer.append(command.position)

            }
        }

        for index in 0 ..< positionsSecondPlayer.count{
            
            markViewForFiveStep(position: positionsFirstPlayer[index],
                                markPrototyp: XView())
            markViewForFiveStep(position: positionsSecondPlayer[index],
                                markPrototyp: OView())
        }



    }


    func markViewForFiveStep(position : GameboardPosition, markPrototyp : MarkView){
        gameboardView.removeMarkView(at: position)
        gameboardView.placeMarkView(markPrototyp.copy(), at: position)

    }
    
    
    // MARK: - State Machine
    
    private func goToFirstState() {

        switch SelectGame.shared.game {
        case .twoPlayers:
            let player = Player.first
            self.currentState = PlayerInputState(
                player: player,
                markPrototype: player.markViewPrototype,
                gameViewController: self,
                gameboard: self.gameboard,
                gameboardView: self.gameboardView
            )
        case .playerVScomputer:
            let player = Player.first
            self.currentState = ComputerInputState(
                player: player,
                markPrototype: player.markViewPrototype,
                gameViewController: self,
                gameboard: self.gameboard,
                gameboardView: self.gameboardView
            )
        case .fiveMoveTwoPlayers:
            let player = Player.first
            self.currentState = FiveMoveInputState(
                player: player,
                markPrototype: player.markViewPrototype,
                gameViewController: self,
                gameboard: self.gameboard,
                gameboardView: self.gameboardView
            )
        }
    }
    
    private func goToNextState() {

        switch SelectGame.shared.game {
        case .twoPlayers:
            if let playerInputState = self.currentState as? PlayerInputState {
                let nextPlayer = playerInputState.player.next
                self.currentState = PlayerInputState(
                    player: nextPlayer,
                    markPrototype: nextPlayer.markViewPrototype,
                    gameViewController: self,
                    gameboard: self.gameboard,
                    gameboardView: self.gameboardView)
            }
        case .playerVScomputer:
            if let computerInputState = self.currentState as? ComputerInputState {
                let nextPlayer = computerInputState.player.next
                self.currentState = ComputerInputState(
                    player: nextPlayer,
                    markPrototype: nextPlayer.markViewPrototype,
                    gameViewController: self,
                    gameboard: self.gameboard,
                    gameboardView: self.gameboardView )

            }
        case .fiveMoveTwoPlayers:
            if let fiveMoveInputState = self.currentState as? FiveMoveInputState {
                let nextPlayer = fiveMoveInputState.player.next
                self.currentState = FiveMoveInputState(
                    player: nextPlayer,
                    markPrototype: nextPlayer.markViewPrototype,
                    gameViewController: self,
                    gameboard: self.gameboard,
                    gameboardView: self.gameboardView )
            }
        }

    }

}

