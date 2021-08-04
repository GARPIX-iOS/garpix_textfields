//
//  CustomTFProtocol.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI
import GXUtilz

// MARK:- Enum

/// This enum helps to format text in CustomTF in onChangeText block
public enum CustomTFFormat {
    case formatPhone
    case formatText(mask: String,
                    symbol: String.Element,
                    inputType: StringInputType?)
}

// MARK:- Protocol

/// This protocol takes all variables wich need to init TF
protocol CustomTFProtocol: CustomTFInputProtocol, CustomTFFormatProtocol {
    var textColor: Color { get set }
    var isEditing: Bool { get set }
    var placeholder: String { get set }
    var width: CGFloat { get set }
    var height: CGFloat { get set }
    var keyboardType: UIKeyboardType { get set }

    /// This variable used only for StandartTextField if you whant to make this field secured for password
    var isShowSecureField: Bool { get set }
    
    /// This variable will always show fractions in NumbersTextField
    var alwaysShowFractions: Bool { get set }
    
    var onTap: () -> Void { get set }
    var onChangeOfIsEditing: (Bool) -> Void { get set }
    var commit: () -> Void { get set }
    var hideKeyboard: () -> Void { get set }
}

// MARK: - CustomTFProtocol SymbolsLimiter

extension CustomTFProtocol {
    
    /// This function limits text length in StandartTextField
    /// - Parameters:
    ///   - text: input text
    ///   - validSymbolsAmount: symbols amount added by user
    ///   - onlyNumbers: shows can user add text from .numpad or from chosen keyboard
    /// - Returns: formatted text
    func limitTextLength(text: String, validSymbolsAmount: Int?, inputType: StringInputTypeProtocol?) -> String {
        let symbol: String.Element = "X"
        guard validSymbolsAmount != nil else { return text }
        return text.formatText(mask: symbolsLimiter(validSymbolsAmount: validSymbolsAmount,
                                                    symbol: symbol),
                               symbol: symbol,
                               inputType: inputType)
    }

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
    /// This function formats text by provided masks
    /// - Parameters:
    ///   - text: input text
    ///   - textFormat: choose formatText if you whant provide your own mask of just do it in your own methods by adding them to onChangeOfText
    ///   - validSymbolsAmount: symbols amount added by user
    ///   - onlyNumbers: shows can user add text from .numpad or from chosen keyboard
    /// - Returns: formatted text
    func formatText(text: String, textFormat: CustomTFFormat?, validSymbolsAmount: Int?, inputType: StringInputTypeProtocol?) -> String {
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
