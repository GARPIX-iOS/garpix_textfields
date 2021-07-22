//
//  CustomTFComponents.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

public struct CustomTFComponents: CustomTFProtocol, CustomTFInputProtocol {
    var inputType: CustomTFType

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
    
    
    // MARK: - Standart Init
    public init(
        text: Binding<String>,
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
        
        commit: @escaping () -> Void = {},
        onTap: @escaping () -> Void = {},
        onChangeOfText: @escaping (String) -> Void = {_ in},
        onChangeOfIsEditing: @escaping (Bool) -> Void = {_ in},
        hideKeyboard: @escaping () -> Void = {}
    ) {
        self.inputType = .standart(text: text)
        
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
        self.alwaysShowFractions = false
        
        self.commit = commit
        self.onTap = onTap
        self.onChangeOfText = onChangeOfText
        self.onChangeOfIsEditing = onChangeOfIsEditing
        self.hideKeyboard = hideKeyboard
    }
    
    // MARK: - Decimal Init
    public init(
        totalInput: Binding<Double?>,
        currencySymbol: String?,
        textColor: Color = .primary,
        isEditing: Bool = false,
        placeholder: String = "",
        width: CGFloat = Display.width * 0.9,
        height: CGFloat = 60,
        keyboardType: UIKeyboardType = .numberPad,
        isShowLeadingButtons: Bool = false,
        isShowTrailingButtons: Bool = false,
        onlyNumbers: Bool = true,
        alwaysShowFractions: Bool = false,
        
        onTap: @escaping () -> Void = {},
        onChangeOfIsEditing: @escaping (Bool) -> Void = {_ in},
        hideKeyboard: @escaping () -> Void = {}
    ) {
        self.inputType = .decimal(totalInput: totalInput,
                                  currencySymbol: currencySymbol)

        self.textColor = textColor
        self.isEditing = isEditing
        self.placeholder = placeholder
        self.width = width
        self.height = height
        self.keyboardType = keyboardType
        self.isShowSecureField = false
        self.isShowLeadingButtons = isShowLeadingButtons
        self.isShowTrailingButtons = isShowTrailingButtons
        self.onlyNumbers = onlyNumbers
        self.validSymbolsAmount = nil
        self.textFormat = nil
        self.alwaysShowFractions = alwaysShowFractions
        
        self.commit = {}
        self.onTap = onTap
        self.onChangeOfText = {_ in}
        self.onChangeOfIsEditing = onChangeOfIsEditing
        self.hideKeyboard = hideKeyboard
    }
    
    // MARK: - Date Init
    public init(
        date: Binding<Date?>,
        formatter: DateFormatter?,
        textColor: Color = .primary,
        isEditing: Bool = false,
        placeholder: String = "",
        width: CGFloat = Display.width * 0.9,
        height: CGFloat = 60,
        isShowLeadingButtons: Bool = false,
        isShowTrailingButtons: Bool = false,

        onTap: @escaping () -> Void = {},
        onChangeOfIsEditing: @escaping (Bool) -> Void = {_ in},
        hideKeyboard: @escaping () -> Void = {}
    )
    {
        self.inputType = .date(date: date,
                               formatter: formatter)
        
        self.textColor = textColor
        self.isEditing = isEditing
        self.placeholder = placeholder
        self.width = width
        self.height = height
        self.keyboardType = .default
        self.isShowSecureField = false
        self.isShowLeadingButtons = isShowLeadingButtons
        self.isShowTrailingButtons = isShowTrailingButtons
        self.onlyNumbers = false
        self.validSymbolsAmount = nil
        self.textFormat = nil
        self.alwaysShowFractions = false

        self.commit = {}
        self.onTap = onTap
        self.onChangeOfText = {_ in}
        self.onChangeOfIsEditing = onChangeOfIsEditing
        self.hideKeyboard = hideKeyboard
    }
}
