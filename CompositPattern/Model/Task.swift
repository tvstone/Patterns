//
//  Task.swift
//  CompositPattern
//
//  Created by Владислав Тихоненков on 18.11.2021.
//

protocol Task {

    var tasks : [String] {get set}

    func loadTask()-> [String]
}


