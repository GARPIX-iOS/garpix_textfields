//
//  DateTextField.swift
//  
//
//  Created by Anton Vlezko on 28.07.2021.
//

import SwiftUI

public struct DateTextField<LeadingContent, TrailingContent>: View, CustomTFButtonsProtocol where LeadingContent: View, TrailingContent: View {
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
    
    var isShowLeadingButtons: Bool
    var isShowTrailingButtons: Bool
    var leadingContent: () -> LeadingContent?
    var trailingContent: () -> TrailingContent?

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
        
        HStack(spacing: 10) {
            leadingButtonsView
            CustomTF(components: components)
            trailingButtonsView
        }
        .frame(width: width, height: height, alignment: .center)
    }
    
    @ViewBuilder
    var leadingButtonsView: some View {
        if isShowLeadingButtons {
            leadingContent()
                .padding(.leading, 16)
        }
    }
    
    @ViewBuilder
    var trailingButtonsView: some View {
        if isShowTrailingButtons {
            trailingContent()
                .padding(.trailing, 16)
        }
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
        width: CGFloat = UIScreen.main.bounds.width * 0.9,
        height: CGFloat = 60,
        onTap: @escaping () -> Void = {},
        onChangeOfIsEditing: @escaping (Bool) -> Void = {_ in},
        hideKeyboard: @escaping () -> Void = {},
        isShowLeadingButtons: Bool = false,
        isShowTrailingButtons: Bool = false,
        @ViewBuilder leadingContent: @escaping () -> LeadingContent?,
        @ViewBuilder trailingContent: @escaping () -> TrailingContent?
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
        self.isShowLeadingButtons = isShowLeadingButtons
        self.isShowTrailingButtons = isShowTrailingButtons
        self.trailingContent = trailingContent
        self.leadingContent = leadingContent
    }
    
    init(
        date: Binding<Date?>,
        formatter: DateFormatter?,
        textColor: Color = .primary,
        isEditing: Binding<Bool> = .constant(false),
        placeholder: String = "",
        width: CGFloat = UIScreen.main.bounds.width * 0.9,
        height: CGFloat = 60,
        onTap: @escaping () -> Void = {},
        onChangeOfIsEditing: @escaping (Bool) -> Void = {_ in},
        hideKeyboard: @escaping () -> Void = {},
        isShowLeadingButtons: Bool = false,
        isShowTrailingButtons: Bool = false
    ) where LeadingContent == EmptyView, TrailingContent == EmptyView
    {
        self.init(
            date: date,
            formatter: formatter,
            textColor: textColor,
            isEditing: isEditing,
            placeholder: placeholder,
            width: width,
            height: height,
            onTap: onTap,
            onChangeOfIsEditing: onChangeOfIsEditing,
            hideKeyboard: hideKeyboard,
            isShowLeadingButtons: isShowLeadingButtons,
            isShowTrailingButtons: isShowTrailingButtons,
            leadingContent: {
                EmptyView()
            },
            trailingContent: {
                EmptyView()
            }
        )
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
        self.isShowLeadingButtons = isShowLeadingButtons
        self.isShowTrailingButtons = isShowTrailingButtons
    }
    
    init(
        date: Binding<Date?>,
        formatter: DateFormatter?,
        textColor: Color = .primary,
        isEditing: Binding<Bool> = .constant(false),
        placeholder: String = "",
        width: CGFloat = UIScreen.main.bounds.width * 0.9,
        height: CGFloat = 60,
        onTap: @escaping () -> Void = {},
        onChangeOfIsEditing: @escaping (Bool) -> Void = {_ in},
        hideKeyboard: @escaping () -> Void = {},
        isShowLeadingButtons: Bool = false,
        isShowTrailingButtons: Bool = false,
        @ViewBuilder trailingContent: @escaping () -> TrailingContent?
    ) where LeadingContent == EmptyView {
        self.init(
            date: date,
            formatter: formatter,
            textColor: textColor,
            isEditing: isEditing,
            placeholder: placeholder,
            width: width,
            height: height,
            onTap: onTap,
            onChangeOfIsEditing: onChangeOfIsEditing,
            hideKeyboard: hideKeyboard,
            isShowLeadingButtons: isShowLeadingButtons,
            isShowTrailingButtons: isShowTrailingButtons,
            leadingContent: {
                EmptyView()
            },
            trailingContent: trailingContent
        )
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
        self.isShowLeadingButtons = isShowLeadingButtons
        self.isShowTrailingButtons = isShowTrailingButtons
        self.trailingContent = trailingContent
    }
    
    init(
        date: Binding<Date?>,
        formatter: DateFormatter?,
        textColor: Color = .primary,
        isEditing: Binding<Bool> = .constant(false),
        placeholder: String = "",
        width: CGFloat = UIScreen.main.bounds.width * 0.9,
        height: CGFloat = 60,
        onTap: @escaping () -> Void = {},
        onChangeOfIsEditing: @escaping (Bool) -> Void = {_ in},
        hideKeyboard: @escaping () -> Void = {},
        isShowLeadingButtons: Bool = false,
        isShowTrailingButtons: Bool = false,
        @ViewBuilder leadingContent: @escaping () -> LeadingContent?
    ) where TrailingContent == EmptyView {
        self.init(
            date: date,
            formatter: formatter,
            textColor: textColor,
            isEditing: isEditing,
            placeholder: placeholder,
            width: width,
            height: height,
            onTap: onTap,
            onChangeOfIsEditing: onChangeOfIsEditing,
            hideKeyboard: hideKeyboard,
            isShowLeadingButtons: isShowLeadingButtons,
            isShowTrailingButtons: isShowTrailingButtons,
            leadingContent: leadingContent,
            trailingContent: {
                EmptyView()
            }
        )
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
        self.isShowLeadingButtons = isShowLeadingButtons
        self.isShowTrailingButtons = isShowTrailingButtons
        self.leadingContent = leadingContent
    }
}
