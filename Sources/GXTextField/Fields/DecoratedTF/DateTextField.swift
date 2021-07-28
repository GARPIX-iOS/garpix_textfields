//
//  DateTextField.swift
//  
//
//  Created by Anton Vlezko on 28.07.2021.
//

import SwiftUI

enum CustomTFContentOptions {
    case none
    case leading
    case trailing
    case horizontal
}

protocol DecoratorTFPtorocol: CustomTFProtocol, CustomTFInputProtocol, CustomTFButtonsProtocol {}

public struct DateTextField<LeadingContent, TrailingContent>: View, DecoratorTFPtorocol where LeadingContent: View, TrailingContent: View {
    var contentOptions: CustomTFContentOptions
    
    var inputType: CustomTFType
    
    var textColor: Color
    @Binding var isEditing: Bool
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
    var onTap: () -> Void
    var onChangeOfText: (String) -> Void
    var onChangeOfIsEditing: (Bool) -> Void
    var commit: () -> Void
    var hideKeyboard: () -> Void
    
    var leadingContent: () -> LeadingContent?
    var trailingContent: () -> TrailingContent?
    
    public init(
        date: Binding<Date?>,
        formatter: DateFormatter?,
        textColor: Color = .primary,
        isEditing: Binding<Bool> = .constant(false),
        placeholder: String = "",
        width: CGFloat = UIScreen.main.bounds.width * 0.9,
        height: CGFloat = 60,
        isShowLeadingButtons: Bool = false,
        isShowTrailingButtons: Bool = false,
        
        onTap: @escaping () -> Void = {},
        onChangeOfIsEditing: @escaping (Bool) -> Void = {_ in},
        hideKeyboard: @escaping () -> Void = {},
        @ViewBuilder leadingContent: @escaping () -> LeadingContent? = { nil },
        @ViewBuilder trailingContent: @escaping () -> TrailingContent? = { nil }
    )
    {
        self.contentOptions = .horizontal
        self.inputType = .date(date: date,
                               formatter: formatter)
        
        self.textColor = textColor
        _isEditing = isEditing
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
        
        self.leadingContent = leadingContent
        self.trailingContent = trailingContent
        
    }
    
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
            isShowLeadingButtons: isShowLeadingButtons,
            isShowTrailingButtons: isShowTrailingButtons,
            onlyNumbers: onlyNumbers,
            validSymbolsAmount: validSymbolsAmount,
            textFormat: textFormat,
            alwaysShowFractions: alwaysShowFractions,
            commit: commit,
            onTap: onTap,
            onChangeOfText: onChangeOfText,
            onChangeOfIsEditing: onChangeOfIsEditing,
            hideKeyboard: hideKeyboard
        )
        switch contentOptions {
        case .none:
            CustomTF(components: components)
        case .leading:
            VStack{}
        case .trailing:
            VStack{}
        case .horizontal:
            CustomTF(components: components, leadingContent: leadingContent, trailingContent: trailingContent)
        }
    }
    
}

public extension DateTextField {
    init(
        date: Binding<Date?>,
        formatter: DateFormatter?,
        textColor: Color = .primary,
        isEditing: Binding<Bool> = .constant(false),
        placeholder: String = "",
        width: CGFloat = UIScreen.main.bounds.width * 0.9,
        height: CGFloat = 60,
        isShowLeadingButtons: Bool = false,
        isShowTrailingButtons: Bool = false,
        
        onTap: @escaping () -> Void = {},
        onChangeOfIsEditing: @escaping (Bool) -> Void = {_ in},
        hideKeyboard: @escaping () -> Void = {}
    ) where LeadingContent == EmptyView, TrailingContent == EmptyView {
        self.init(
            date: date,
            formatter: formatter,
            textColor: textColor,
            isEditing: isEditing,
            placeholder: placeholder,
            width: width,
            height: height,
            isShowLeadingButtons: isShowLeadingButtons,
            isShowTrailingButtons: isShowTrailingButtons,
            leadingContent: {
                EmptyView()
            },
            trailingContent: {
                EmptyView()
            }
        )
        self.contentOptions = .none
        
        self.inputType = .date(date: date,
                               formatter: formatter)
        
        self.keyboardType = .default
        self.isShowSecureField = false

        self.onlyNumbers = false
        self.validSymbolsAmount = nil
        self.textFormat = nil
        self.alwaysShowFractions = false
        
        self.commit = {}
        self.onChangeOfText = {_ in}

    }
}
