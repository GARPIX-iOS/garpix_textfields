//
//  StandartTextField.swift
//  
//
//  Created by Anton Vlezko on 28.07.2021.
//

import SwiftUI

/// Это текстовое поле используется для ввода строковых значений. Вы можете легко использовать маску в завершении onChangeOfText или использовать наши значения в textFormat, более того, если вы добавите validSymbolsAmount, вы получите поле с таким количеством символов для дополнительной проверки файла TextFieldSample
public struct StandartTextField: View, CustomTFProtocol {
    // MARK: - Properties
    
    /// Это значение помогает CustomERS распознать, какой тип ввода вы хотите передать
    var inputType: CustomTFType
    
    var textColor: Color
    @Binding var isEditing: Bool
    var placeholder: String
    var width: CGFloat
    var height: CGFloat
    var keyboardType: UIKeyboardType
    
    /// Эта переменная используется только для стандартного текстового поля, если вы хотите защитить это поле от пароля
    var isShowSecureField: Bool
    
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
