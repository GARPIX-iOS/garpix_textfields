//
//  PlainTextField.swift
//  Red
//
//  Created by Danil Lomaev on 29.03.2021.
//

import SwiftUI

public struct PlainTextField<TrailingButtons: View>: View, PlainTextFieldProtocol {
    // MARK: - Properties
    
    @Binding var text: String
    @Binding var borderStyle: BorderStyles
    @Binding var isEditing: Bool
    var trailingButtons: TrailingButtons
    
    // Properties not required to initialize
    @Binding var image: String
    var label: String
    var placeholder: String
    var width: CGFloat
    var showLabelAfterEnteringText: Bool
    var showDeleteButton: Bool
    var onlyNumbers: Bool
    @Binding var validSymbolsAmount: Int?
    
    // MARK: - Init
    
    public init(
        text: Binding<String>,
        borderStyle: Binding<BorderStyles>,
        isEditing: Binding<Bool>,
        trailingButtons: TrailingButtons,
        image: Binding<String> = .constant(""),
        label: String = "",
        placeholder: String = "",
        width: CGFloat = Display.width * 0.9,
        showLabelAfterEnteringText: Bool = true,
        showDeleteButton: Bool = false,
        onlyNumbers: Bool = false
    ) {
        _text = text
        _borderStyle = borderStyle
        _isEditing = isEditing
        self.trailingButtons = trailingButtons
        
        // Properties not required to initialize
        _image = image
        self.label = label
        self.placeholder = placeholder
        self.width = width
        self.showLabelAfterEnteringText = showLabelAfterEnteringText
        self.showDeleteButton = showDeleteButton
        self.onlyNumbers = onlyNumbers
        _validSymbolsAmount = .constant(nil)
    }
    
    public var body: some View {
        let components = TextFieldStyleComponents(
            text: text,
            borderStyle: borderStyle,
            isEditing: isEditing,
            trailingButtons: trailingButtons,
            image: image,
            label: labelCalculator(text: text),
            width: width,
            keyboardType: keyboardTypeCalculator(onlyNumbers: onlyNumbers),
            showDeleteButton: showDeleteButton,
            onTap: {
                isEditing = true
            },
            onChangeOfText: { value in
                text = limitTextLength(text: text,
                                       validSymbolsAmount: validSymbolsAmount,
                                       onlyNumbers: onlyNumbers)
            },
            onChangeOfIsEditing: { value in
                borderStyle = value ? .selected : .standart
            },
            deleteTapped: {
                text = ""
            },
            hideKeyboard: {
                hideKeyboard()
            }
        )
        
        CustomTextField(
            placeholder: placeholder,
            text: $text,
            editingChanged: { isEdit in
                if !isEdit {
                    withAnimation(.spring()) {
                        isEditing = false
                    }
                }
            }
        )
        .textFieldStyle(components: components)
        .autocapitalization(.words)
    }
}

struct PlainTextField_Previews: PreviewProvider {
    static var previews: some View {
        PlainTextField(text: .constant(""),
                       borderStyle: .constant(.selected),
                       isEditing: .constant(false),
                       trailingButtons: ClearTextButton(clearingText: .constant("")),
                       image: .constant("checkmark"),
                       label: "Фамилия")
    }
}

// MARK: - init with valid symbols

extension PlainTextField {
    
    public init(
        text: Binding<String>,
        borderStyle: Binding<BorderStyles>,
        isEditing: Binding<Bool>,
        trailingButtons: TrailingButtons,
        image: Binding<String> = .constant(""),
        label: String = "",
        placeholder: String = "",
        width: CGFloat = Display.width * 0.9,
        showLabelAfterEnteringText: Bool = true,
        showDeleteButton: Bool = false,
        onlyNumbers: Bool = false,
        validSymbolsAmount: Binding<Int?>
    ) {
        _text = text
        _borderStyle = borderStyle
        _isEditing = isEditing
        self.trailingButtons = trailingButtons
        
        // Properties not required to initialize
        _image = image
        self.label = label
        self.placeholder = placeholder
        self.width = width
        self.showLabelAfterEnteringText = showLabelAfterEnteringText
        self.showDeleteButton = showDeleteButton
        self.onlyNumbers = onlyNumbers
        _validSymbolsAmount = validSymbolsAmount
    }
}
