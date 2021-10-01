//
//  CustomTFProtocol.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI
import GXUtilz

// MARK:- Enum

/// Это перечисление помогает форматировать текст в CustomTF в блоке onChangeText
public enum CustomTFFormat {
    case formatPhone
    case formatText(mask: String,
                    symbol: String.Element,
                    inputType: StringInputType?)
}

// MARK:- Protocol

/// Этот протокол принимает все переменные, необходимые для инициализации TF
protocol CustomTFProtocol: CustomTFInputProtocol, CustomTFFormatProtocol {
    var textColor: Color { get set }
    var placeholderColor: Color? { get set }
    var isEditing: Bool { get set }
    var placeholder: String { get set }
//    var width: CGFloat? { get set }
//    var height: CGFloat? { get set }
    var keyboardType: UIKeyboardType { get set }

    /// Эта переменная используется только для стандартного текстового поля, если вы хотите защитить это поле от пароля
    var isShowSecureField: Bool { get set }
    
    /// Эта переменная всегда будет показывать дроби в NumbersTextField
    var alwaysShowFractions: Bool { get set }
    
    var onTap: () -> Void { get set }
    var onChangeOfIsEditing: (Bool) -> Void { get set }
    var commit: () -> Void { get set }
    var hideKeyboard: () -> Void { get set }
}

// MARK: - CustomTFProtocol SymbolsLimiter

extension CustomTFProtocol {
    /// Эта функция ограничивает длину текста в StandartTextField
    /// - Parameters:
    ///   - text: ввод текста
    ///   - validSymbolsAmount: количество символов, добавленных пользователем
    ///   - inputType: необходим для задания пользователем характеристик форматируемого текста, может быть опциональным
    /// - Returns: форматированный текст
    func limitTextLength(text: String, validSymbolsAmount: Int?, inputType: StringInputType?) -> String {
        let symbol: String.Element = "X"
        guard validSymbolsAmount != nil else { return text }
        return text.formatText(mask: symbolsLimiter(validSymbolsAmount: validSymbolsAmount,
                                                    symbol: symbol),
                               symbol: symbol,
                               inputType: inputType)
    }

    /// Данная функция создает строку из символов переданных пользователем
    /// - Parameters:
    ///   - validSymbolsAmount: количество символов, добавленных пользователем
    ///   - symbol: символ
    /// - Returns: Строка из символов
    private func symbolsLimiter(validSymbolsAmount: Int?, symbol: String.Element) -> String {
        var result = ""
        guard let symbolsLimit = validSymbolsAmount else { return result }
        guard symbolsLimit >= 1 else { return result }

        for _ in 0 ... symbolsLimit - 1 {
            result.append(symbol)
        }
        return result
    }
}

// MARK: - CustomTFProtocol Text Formatter

extension CustomTFProtocol {
    /// Эта функция форматирует текст с помощью введенных масок
    /// - Parameters:
    ///   - text: ввод текста
    ///   - textFormat: выберите formatText, если вы хотите предоставить свою собственную маску, просто сделайте это своими собственными методами, добавив их в onChangeOfText
    ///   - validSymbolsAmount: количество символов, добавленных пользователем
    ///   - inputType: необходим для задания пользователем характеристик форматируемого текста, может быть опциональным
    /// - Returns: форматированный текст
    func formatText(text: String, textFormat: CustomTFFormat?, validSymbolsAmount: Int?, inputType: StringInputType?) -> String {
        guard let format = textFormat else {
            return limitTextLength(text: text, validSymbolsAmount: validSymbolsAmount, inputType: inputType)
        }
        
        switch format {
        case .formatPhone:
            return text.formatPhone()
        case .formatText(mask: let mask,
                         symbol: let symbol,
                         inputType: let inputType):
            return text.formatText(mask: mask,
                                   symbol: symbol,
                                   inputType: inputType)
        }
    }
}
