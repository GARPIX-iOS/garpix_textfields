//
//  File.swift
//  
//
//  Created by Anton Vlezko on 04.08.2021.
//

import SwiftUI

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
