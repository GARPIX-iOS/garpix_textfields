//
//  CustomTFInputProtocol.swift
//  
//
//  Created by Anton Vlezko on 28.07.2021.
//

import SwiftUI
import GXUtilz

// MARK:- Enum

/// This enum tells the type of CustomTF helps to manage input data in DecoratedTF
enum CustomTFType {
    case standart(text: Binding<String>)
    case decimal(totalInput: Binding<Double?>, currencySymbol: String?)
    case date(date: Binding<Date?>, formatter: DateFormatter?)
}

// MARK:- Protocol

/// This protocol is used to add inputType values to CustomTF
protocol CustomTFInputProtocol {
    var inputType: CustomTFType { get set }
}

protocol CustomTFFormatProtocol {
    var formatType: CustomTFFormatType? { get set }
}

public struct CustomTFFormatType {
    var validSymbolsAmount: Int?
    var inputType: StringInputType?
    var textFormat: CustomTFFormat?
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

public struct StringInputType: StringInputTypeProtocol {
    public var formatLanguage: FormatWithLanguage = .eng
    public var containsText: Bool
    public var containsNumbers: Bool
    public var containsSpecialSymbols: Bool
}
