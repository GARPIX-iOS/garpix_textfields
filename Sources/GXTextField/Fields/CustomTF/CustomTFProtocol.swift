//
//  CustomTFProtocol.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

public enum CustomTFFormat {
    case formatPhone
    case formatGosNumber(mask: String, letterSymbol: String.Element, numberSymbol: String.Element)
    case formatText(mask: String, symbol: String.Element)
}

protocol CustomTFProtocol {
    var textColor: Color { get set }
    var isEditing: Bool { get set }
    var placeholder: String { get set }
    var width: CGFloat { get set }
    var height: CGFloat { get set }
    var keyboardType: UIKeyboardType { get set }
    var isShowSecureField: Bool { get set }
    var isShowLeadingButtons: Bool { get set }
    var isShowTrailingButtons: Bool { get set }
    var onlyNumbers: Bool { get set }
    var validSymbolsAmount: Int? { get set }
    var textFormat: CustomTFFormat? { get set }
    
    var onTap: () -> Void { get set }
    var onChangeOfText: (String) -> Void { get set }
    var onChangeOfIsEditing: (Bool) -> Void { get set }
    var commit: () -> Void { get set }
    var hideKeyboard: () -> Void { get set }
}

// MARK: - SymbolsLimiter

extension CustomTFProtocol {
    func limitTextLength(text: String, validSymbolsAmount: Int?, onlyNumbers: Bool) -> String {
        let symbol: String.Element = "X"
        guard validSymbolsAmount != nil else { return text }
        return text.formatText(with: symbolsLimiter(validSymbolsAmount: validSymbolsAmount,
                                                    symbol: symbol),
                               symbol: symbol,
                               onlyNumbers: onlyNumbers)
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

// MARK: - Text Formatter

extension CustomTFProtocol {
    func formatText(text: String, textFormat: CustomTFFormat?, validSymbolsAmount: Int?, onlyNumbers: Bool) -> String {
        guard let format = textFormat else {
            return limitTextLength(text: text, validSymbolsAmount: validSymbolsAmount, onlyNumbers: onlyNumbers)
        }
        
        switch format {
        case .formatPhone:
            return text.formatPhone()
        case .formatGosNumber(mask: let mask, letterSymbol: let letterSymbol, numberSymbol: let numberSymbol):
            return text.formatGosnumber(with: mask, letterSymbol: letterSymbol, numberSymbol: numberSymbol)
        case .formatText(mask: let mask, symbol: let symbol):
            return text.formatText(with: mask, symbol: symbol, onlyNumbers: onlyNumbers)
        }
    }
}
