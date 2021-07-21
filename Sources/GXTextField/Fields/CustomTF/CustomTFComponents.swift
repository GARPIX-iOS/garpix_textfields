//
//  CustomTFComponents.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

public struct CustomTFComponents: CustomTFProtocol {
    var textColor: Color
    var isEditing: Bool
    var placeholder: String
    var width: CGFloat
    var height: CGFloat
    var keyboardType: UIKeyboardType
    var isShowSecureField: Bool
    var isShowLeadingButtons: Bool
    var isShowTrailingButtons: Bool
    var onlyNumbers: Bool
    var validSymbolsAmount: Int?
    var textFormat: CustomTFFormat?
    var alwaysShowFractions: Bool
    
    var commit: () -> Void
    var onTap: () -> Void
    var onChangeOfText: (String) -> Void
    var onChangeOfIsEditing: (Bool) -> Void
    var hideKeyboard: () -> Void
    
    public init(
        textColor: Color = .primary,
        isEditing: Bool = false,
        placeholder: String = "",
        width: CGFloat = Display.width * 0.9,
        height: CGFloat = 60,
        keyboardType: UIKeyboardType = .default,
        isShowSecureField: Bool = false,
        isShowLeadingButtons: Bool = false,
        isShowTrailingButtons: Bool = false,
        onlyNumbers: Bool = false,
        validSymbolsAmount: Int? = nil,
        textFormat: CustomTFFormat? = nil,
        alwaysShowFractions: Bool = false,
        
        commit: @escaping () -> Void = {},
        onTap: @escaping () -> Void = {},
        onChangeOfText: @escaping (String) -> Void = {_ in},
        onChangeOfIsEditing: @escaping (Bool) -> Void = {_ in},
        hideKeyboard: @escaping () -> Void = {}
    ) {
        self.textColor = textColor
        self.isEditing = isEditing
        self.placeholder = placeholder
        self.width = width
        self.height = height
        self.keyboardType = keyboardType
        self.isShowSecureField = isShowSecureField
        self.isShowLeadingButtons = isShowLeadingButtons
        self.isShowTrailingButtons = isShowTrailingButtons
        self.onlyNumbers = onlyNumbers
        self.validSymbolsAmount = validSymbolsAmount
        self.textFormat = textFormat
        self.alwaysShowFractions = alwaysShowFractions
        
        self.commit = commit
        self.onTap = onTap
        self.onChangeOfText = onChangeOfText
        self.onChangeOfIsEditing = onChangeOfIsEditing
        self.hideKeyboard = hideKeyboard
    }
}
