//
//  File.swift
//  
//
//  Created by Anton Vlezko on 04.08.2021.
//

import SwiftUI
import GXUtilz

/// Данный протокол реализует функционал по добавлению переменных либо замыканий для форматирования текста
protocol CustomTFFormatProtocol {
    var formatType: CustomTFFormatType? { get set }
}

/// Данная структура необходима для передачи в нее данных по форматированию текста
public struct CustomTFFormatType {
    
    /// Указывая количество символов в данной переменной вы ограничиваете число символов которые может ввести пользователь в TF
    var validSymbolsAmount: Int?
    /// inputType для текста введенного через validSymbolsAmount можете указать там только спецсимволы к примеру или язык для ввода
    var inputType: StringInputType?
    /// Выберете тут один из кейсов перечиления для того, чтобы отформатировать текст по предоставленному нами способу
    var textFormat: CustomTFFormat?
    /// Используйте если хотите провести какие-то кастомные операции с текстом
    var onChangeOfText: (String) -> Void
    
    public init(
        validSymbolsAmount: Int
    ) {
        self.validSymbolsAmount = validSymbolsAmount
        self.inputType = nil
        self.textFormat = nil
        self.onChangeOfText = { _ in }
    }
    
    public init(
        validSymbolsAmount: Int,
        inputType: StringInputType?
    ) {
        self.validSymbolsAmount = validSymbolsAmount
        self.inputType = inputType
        self.textFormat = nil
        self.onChangeOfText = { _ in }
    }
    
    public init(
        textFormat: CustomTFFormat
    ) {
        self.validSymbolsAmount = nil
        self.inputType = nil
        self.textFormat = textFormat
        self.onChangeOfText = { _ in }
    }
    
    public init(
        onChangeOfText: @escaping (String) -> Void
    ) {
        self.validSymbolsAmount = nil
        self.inputType = nil
        self.textFormat = nil
        self.onChangeOfText = onChangeOfText
    }
}
