//
//  TextFieldPropertiesProtocol.swift
//  Red
//
//  Created by Admin on 16.06.2021.
//

import SwiftUI

protocol TextFieldPropertiesProtocol {
    var borderStyle: BorderStyles { get set }
    var isEditing: Bool { get set }

    // Properties not required to initialize
    var image: String { get set }
    var label: String { get set }
    var placeholder: String { get set }
    var width: CGFloat { get set }
    var showLabelAfterEnteringText: Bool { get set }
}

// MARK: - Helper Functions

extension TextFieldPropertiesProtocol {
    // TODO: - Refactor to generic function
    func labelCalculator(date: Date?) -> String {
        withAnimation(.easeOut(duration: 0.3)) {
            showLabelAfterEnteringText ? (date == nil ? "" : label) : label
        }
    }

    func labelCalculator(totalInput: Double?) -> String {
        withAnimation(.easeOut(duration: 0.3)) {
            showLabelAfterEnteringText ? (totalInput == nil ? "" : label) : label
        }
    }

    func labelCalculator(selectedIndex: Int?) -> String {
        withAnimation(.easeOut(duration: 0.3)) {
            showLabelAfterEnteringText ? (selectedIndex == nil ? "" : label) : label
        }
    }

    func labelCalculator(text: String) -> String {
        withAnimation(.easeOut(duration: 0.3)) {
            showLabelAfterEnteringText ? (text == "" ? "" : label) : label
        }
    }

    func keyboardTypeCalculator(onlyNumbers: Bool) -> UIKeyboardType {
        return onlyNumbers ? .numberPad : .default
    }

    func keyboardTypeCalculator(onlyEnglish: Bool) -> UIKeyboardType {
        return onlyEnglish ? .asciiCapable : .default
    }
}

// MARK: - SymbolsLimiter

extension TextFieldPropertiesProtocol {
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
