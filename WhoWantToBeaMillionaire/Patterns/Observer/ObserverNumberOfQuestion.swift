//
//  ObserverNumberOfQuestion.swift
//  WhoWantToBeaMillionaire
//
//  Created by Владислав Тихоненков on 08.11.2021.
//

import Foundation
import UIKit

public protocol EventProtocol {
    associatedtype Parameter

    /// Добавление нового слушателя
    static func += (event: Self, handler: EventObserver<Parameter>)
}

/// База для обработчиков сообщений.
public class EventObserver<Parameter> {
    /// Обработать полученное событие.
    /// Возвращает статус true - слушатель готов получать
    /// дальнейшие события. false - больше не посылать.
    public func handle(_ value: Parameter) -> Bool {
        fatalError("must override")
    }
}

