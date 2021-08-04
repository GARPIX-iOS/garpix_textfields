//
//  CustomTFInputProtocol.swift
//  
//
//  Created by Anton Vlezko on 28.07.2021.
//

import SwiftUI
import GXUtilz

// MARK:- Enum

/// Это перечисление сообщает, что тип CustomTF помогает управлять входными данными в DecoratedTF
enum CustomTFType {
    case standart(text: Binding<String>)
    case decimal(totalInput: Binding<Double?>, currencySymbol: String?)
    case date(date: Binding<Date?>, formatter: DateFormatter?)
}

// MARK:- Protocol

/// Этот протокол используется для добавления значений inputType в CustomTF
protocol CustomTFInputProtocol {
    var inputType: CustomTFType { get set }
}

// MARK:- Struct
public struct StringInputType: StringInputTypeProtocol {
    public var formatLanguage: FormatWithLanguage = .eng
    public var containsText: Bool
    public var containsNumbers: Bool
    public var containsSpecialSymbols: Bool
}
