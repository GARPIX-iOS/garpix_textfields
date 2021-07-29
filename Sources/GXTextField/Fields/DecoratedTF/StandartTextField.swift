//
//  StandartTextField.swift
//  
//
//  Created by Anton Vlezko on 28.07.2021.
//

import SwiftUI

public struct StandartTextField: View, CustomTFProtocol {
    var inputType: CustomTFType
    
    var textColor: Color
    @Binding var isEditing: Bool
    var placeholder: String
    var width: CGFloat
    var height: CGFloat
    var keyboardType: UIKeyboardType
    var isShowSecureField: Bool
    var onlyNumbers: Bool
    var validSymbolsAmount: Int?
    var textFormat: CustomTFFormat?
    var alwaysShowFractions: Bool
    
    var onTap: () -> Void
    var onChangeOfIsEditing: (Bool) -> Void
    var onChangeOfText: (String) -> Void
    var commit: () -> Void
    var hideKeyboard: () -> Void
    
    public var body: some View {
        let components = CustomTFComponents(
            inputType: inputType,
            textColor: textColor,
            isEditing: $isEditing,
            placeholder: placeholder,
            width: width,
            height: height,
            keyboardType: keyboardType,
            isShowSecureField: isShowSecureField,
            onlyNumbers: onlyNumbers,
            validSymbolsAmount: validSymbolsAmount,
            textFormat: textFormat,
            alwaysShowFractions: alwaysShowFractions,
            commit: commit,
            onTap: onTap,
            onChangeOfText: onChangeOfText,
            onChangeOfIsEditing: onChangeOfIsEditing,
            hideKeyboard: hideKeyboard)
        
        CustomTF(components: components)
            .frame(width: width, height: height, alignment: .center)
    }
}

// MARK: - Init
public extension StandartTextField {
    init(
        text: Binding<String>,
        textColor: Color = .primary,
        isEditing: Binding<Bool> = .constant(false),
        placeholder: String = "",
        width: CGFloat = .infinity,
        height: CGFloat = 60,
        keyboardType: UIKeyboardType = .default,
        isShowSecureField: Bool = false,
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
        _isEditing = isEditing
        self.placeholder = placeholder
        self.width = width
        self.height = height
        self.keyboardType = keyboardType
        self.isShowSecureField = isShowSecureField
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
}
