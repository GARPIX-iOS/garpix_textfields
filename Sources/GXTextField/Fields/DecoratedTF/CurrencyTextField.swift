//
//  CurrencyTextField.swift
//  
//
//  Created by Anton Vlezko on 28.07.2021.
//

import SwiftUI

/// This textfield is used to input prices and etc. You can change the currency as string and control other values for more check TextFieldSample file
public struct CurrencyTextField: View, CustomTFProtocol {
    // MARK: - Properties
    
    /// This value helps CustomTF recognize what input type you whant to pass
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
    
    /// This variable will always show fractions in NumbersTextField
    var alwaysShowFractions: Bool
    
    var formatType: CustomTFFormatType?
    var onTap: () -> Void
    var onChangeOfIsEditing: (Bool) -> Void
    var commit: () -> Void
    var hideKeyboard: () -> Void
    
    
    // MARK: - Init
    public init(
        totalInput: Binding<Double?>,
        currencySymbol: String?,
        textColor: Color = .primary,
        isEditing: Binding<Bool> = .constant(false),
        placeholder: String = "",
        width: CGFloat = UIScreen.main.bounds.width * 0.9,
        height: CGFloat = 60,
        alwaysShowFractions: Bool = false,

        onTap: @escaping () -> Void = {},
        onChangeOfIsEditing: @escaping (Bool) -> Void = {_ in},
        hideKeyboard: @escaping () -> Void = {}
    ) {
        self.inputType = .decimal(totalInput: totalInput,
                                  currencySymbol: currencySymbol)

        self.textColor = textColor
        _isEditing = isEditing
        self.placeholder = placeholder
        self.width = width
        self.height = height
        self.keyboardType = .numberPad
        self.isShowSecureField = false
        self.onlyNumbers = true
        self.validSymbolsAmount = nil
        self.alwaysShowFractions = alwaysShowFractions

        self.commit = {}
        self.onTap = onTap
        self.formatType = nil
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
