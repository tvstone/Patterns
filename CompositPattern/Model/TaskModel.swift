//
//  TaskModel.swift
//  CompositPattern
//
//  Created by Владислав Тихоненков on 20.11.2021.
//

import Foundation

class TaskModel {

    static var shared = TaskModel()

    var firstTasks = [String]()
    var subTasks = [[String]]()

}
