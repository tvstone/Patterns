//
//  GameRealm.swift
//  WhoWantToBeaMillionaire
//
//  Created by Владислав Тихоненков on 07.11.2021.
//

import Foundation
import RealmSwift

final class GameRealmStatistic : Object {

        @objc dynamic var date = String()
        @objc dynamic var numberOfQuestion = Int()
        @objc dynamic var moneyInPurse = Int()

        convenience init(date : String, numberOfQuestion : Int, moneyInPurse : Int) {
            self.init()
            self.date = date
            self.numberOfQuestion = numberOfQuestion
            self.moneyInPurse = moneyInPurse

        }

    override class func primaryKey () -> String?{
        return "date"
    }
}



