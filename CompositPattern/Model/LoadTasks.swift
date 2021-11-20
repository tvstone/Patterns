//
//  loadTasks.swift
//  CompositPattern
//
//  Created by Владислав Тихоненков on 20.11.2021.
//

import Foundation

final class LoadTasks{
    
    let firstTasks = ["Ремонт квартиры","Ремонт машины","Поездка за границу","Рыбалка"]
    let task1 = ["Ремонт пола", "Ремонт потолка"]
    let task2 = ["Ремонт коробки передач", "Ремонт мотора"]
    let task3 = ["Финансирование поезди ", "Выбор страны поездки"]
    let task4 = ["Купить удочку", "Купить прикорм"]
    var subTasks = [[String]]()
    var secondSubTasks = [[[String]]]()

 
    func addTask () {

        subTasks.append(task1)
        subTasks.append(task2)
        subTasks.append(task3)
        subTasks.append(task4)

        TaskModel.shared.firstTasks = firstTasks
        TaskModel.shared.subTasks = subTasks
      

    }
}
