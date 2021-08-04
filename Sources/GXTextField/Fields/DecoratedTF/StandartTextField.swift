//
//  StandartTextField.swift
//  
//
//  Created by Anton Vlezko on 28.07.2021.
//

import SwiftUI

/// This textfield is used to input string values. You can easily use mask in onChangeOfText completion or use our values in textFormat, moreover if you will add validSymbolsAmount you will get field with that amount of symbols for more check TextFieldSample file
public struct StandartTextField: View, CustomTFProtocol {
    // MARK: - Properties
    
    /// This value helps CustomTF recognize what input type you whant to pass
    var inputType: CustomTFType
    
    var textColor: Color
    @Binding var isEditing: Bool
    var placeholder: String
    var width: CGFloat
    var height: CGFloat
    var keyboardType: UIKeyboardType
    
    /// This variable used only for StandartTextField if you whant to make this field secured for password
    var isShowSecureField: Bool
    /// This variable should be turned to true if you would like to use string with only numbers in formatText extension replacing occurancies will be switched to numbers and keyboard type in CustomTFAction will be switched to .numpad
    var onlyNumbers: Bool
    /// This variable will limit number of string symbols works only with StandartTextField
    var validSymbolsAmount: Int?
    var alwaysShowFractions: Bool
    
    var formatType: CustomTFFormatType?
    var onTap: () -> Void
    var onChangeOfIsEditing: (Bool) -> Void
    var commit: () -> Void
    var hideKeyboard: () -> Void
    
    // MARK: - Init
    public init(
        text: Binding<String>,
        textColor: Color = .primary,
        isEditing: Binding<Bool> = .constant(false),
        placeholder: String = "",
        width: CGFloat = UIScreen.main.bounds.width * 0.9,
        height: CGFloat = 60,
        keyboardType: UIKeyboardType = .default,
        isShowSecureField: Bool = false,
        onlyNumbers: Bool = false,
        validSymbolsAmount: Int? = nil,

        formatType: CustomTFFormatType? = nil,
        commit: @escaping () -> Void = {},
        onTap: @escaping () -> Void = {},
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
        self.alwaysShowFractions = false

        self.formatType = formatType
        self.commit = commit
        self.onTap = onTap
        self.onChangeOfIsEditing = onChangeOfIsEditing
        self.hideKeyboard = hideKeyboard
    }
    
    // MARK: - View
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
            alwaysShowFractions: alwaysShowFractions,
            formatType: formatType,
            commit: commit,
            onTap: onTap,
            onChangeOfIsEditing: onChangeOfIsEditing,
            hideKeyboard: hideKeyboard)
        
        CustomTF(components: components)
            .frame(minWidth: 0, maxWidth: width, minHeight: 0, maxHeight: height, alignment: .center)
    }
}
