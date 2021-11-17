//
//  AnalyticsManager.swift
//  XO-game
//
//  Created by v.prusakov on 11/4/21.
//  Copyright © 2021 plasmon. All rights reserved.
//

enum Event {
    case playerInput(player: Player, position: GameboardPosition)
    case gameFinished(winner: Player?)
    case restartGame
}

final class EventCommand {
    let event: Event
    let commandsForViveSteps = [Player : GameboardPosition]()
    
    init(event: Event) {
        self.event = event
    }


    var logMessage: String {
        switch event {
        case .playerInput(let player, let position):
            return "\(player) placed mark at \(position)"
        case .gameFinished(let winner):
            if let winner = winner {
                return "\(winner) win the game"
            } else {
                return "No winner"
            }
        case .restartGame: return "Game was restarted"
        }
    }
    
    func fiveStepCommands(){
        switch event {
        case .playerInput(let player, let position):
            let fiveStepCommand = Commands(player: player, position: position)
            SelectGame.shared.allCommandsFiveSteps.append(fiveStepCommand)
        default:
            break
        }
    }
}

class AnalyticsManager {
    static let shared = AnalyticsManager()
    
    var batchSize = 11
    var commands: [EventCommand] = []

    
    func addCommand(_ command: EventCommand) {
        self.commands.append(command)
        self.executeCommandsIfNeeded()

    }
    
    private func executeCommandsIfNeeded() {
        guard self.commands.count >= self.batchSize else {
            return
        }
        
        self.commands.forEach {
            $0.fiveStepCommands()
            print($0.logMessage)
        }
        self.commands = []
    }
}

func recordEvent(_ event: Event) {
    AnalyticsManager.shared.addCommand(EventCommand(event: event))




}
