//
//  DateTextField.swift
//  
//
//  Created by Anton Vlezko on 28.07.2021.
//

import SwiftUI

public struct DateTextField: View, CustomTFProtocol {
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
public extension DateTextField {
    init(
        date: Binding<Date?>,
        formatter: DateFormatter?,
        textColor: Color = .primary,
        isEditing: Binding<Bool> = .constant(false),
        placeholder: String = "",
        width: CGFloat = .infinity,
        height: CGFloat = 60,
        onTap: @escaping () -> Void = {},
        onChangeOfIsEditing: @escaping (Bool) -> Void = {_ in},
        hideKeyboard: @escaping () -> Void = {}
    )
    {
        self.inputType = .date(date: date,
                               formatter: formatter)
        
        self.textColor = textColor
        _isEditing = isEditing
        self.placeholder = placeholder
        self.width = width
        self.height = height
        self.keyboardType = .default
        self.isShowSecureField = false
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
