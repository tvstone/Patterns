//
//  Game.swift
//  WhoWantToBeaMillionaire
//
//  Created by Владислав Тихоненков on 05.11.2021.
//

import UIKit
final class Game  {

    static var shared = Game()
    var numberOfQuestion = 0
    var moneyInPurse = 0
    var date = ""
    var allStatisticGame = [Any]()

    let shadowOpacity : Float = 0.7
    let shadowColor : UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    let shadowOffset : CGSize = CGSize(width: 6, height: 6)
    let shadowRadius : CGFloat = 10

    let dateFormatter : DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "HH:mm  dd.MM.yyyy "
        return df
    }()

    var backgroundAll = #colorLiteral(red: 0.0181156043, green: 0.04797068983, blue: 0.2869391739, alpha: 1)

}



