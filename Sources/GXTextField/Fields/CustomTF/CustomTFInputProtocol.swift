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
    
    public init(validSymbolsAmount: Int,
                inputType: StringInputType?)
    {
        self.validSymbolsAmount = validSymbolsAmount
        self.inputType = inputType
        self.textFormat = nil
        self.onChangeOfText = { _ in }
    }
    
    public init(textFormat: CustomTFFormat) {
        self.validSymbolsAmount = nil
        self.inputType = nil
        self.textFormat = textFormat
        self.onChangeOfText = { _ in }
    }
    
    public init(onChangeOfText: @escaping (String) -> Void) {
        self.validSymbolsAmount = nil
        self.inputType = nil
        self.textFormat = nil
        self.onChangeOfText = onChangeOfText
    }
}

public struct StringInputType {
    var formatLanguage: FormatWithLanguage1 = .eng
    var containsText: Bool
    var containsNumbers: Bool
    var containsSpecialSymbols: Bool

    func calculateTextReplacing() -> String {
        var text = ""
        let textReplacing = formatLanguage.textReplacing
        let numbersReplacing = "[^0-9]"
        let specialSymbols = " !\"#$%&'()*+,-./:;<=>?@\\[\\\\\\]^_`{|}~].{8,}$"
        
        if containsText == true {
            text += textReplacing
        }
        
        if containsNumbers == true {
            text += numbersReplacing
        }
        
        if containsSpecialSymbols == true {
            text += specialSymbols
        }
        
        return text
    }
}

public enum FormatWithLanguage1 {
    case rus
    case eng
    
    var textReplacing: String {
        switch self {
        case .rus:
            return "[^А-Яа-я]"
        case .eng:
            return "[^A-Za-z]"
        }
    }
}

public extension String {
    func formatText(mask: String = "XXX",
                    symbol: String.Element = "X",
                    inputType: StringInputType?) -> String {
        var result = ""
        var value = self
        let textReplacing = inputType?.calculateTextReplacing() ?? ""
        
        // value iterator
        var index = value.startIndex
        value = replacingOccurrences(of: textReplacing, with: "", options: .regularExpression)

        // iterate over the mask characters until the iterator of values ends
        for ch in mask where index < value.endIndex {
            if ch == symbol {
                // mask requires a value in this place, so take the next one
                result.append(value[index])

                // move values iterator to the next index
                index = value.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    
    func formatTextAndNumbers(mask: String = "X 111 XX 111",
                              firstSymbol: String.Element = "X",
                              secondSymbol: String.Element = "1",
                              firstSymbolType: StringInputType?,
                              secondSymbolType: StringInputType?) -> String {
        var result = ""
        let value = replacingOccurrences(of: " ", with: "")
        let firstSymbolReplacing = firstSymbolType?.calculateTextReplacing() ?? ""
        let secondSymbolReplacing = secondSymbolType?.calculateTextReplacing() ?? ""
        
        var index = value.startIndex
                
        for ch in mask where index < value.endIndex {
            if ch == firstSymbol {
                result.append(String(value[index]).replacingOccurrences(of: firstSymbolReplacing, with: "", options: .regularExpression))
                index = value.index(after: index)
            } else if ch == secondSymbol {
                result.append(String(value[index]).replacingOccurrences(of: secondSymbolReplacing, with: "", options: .regularExpression))
                index = value.index(after: index)
            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
}


