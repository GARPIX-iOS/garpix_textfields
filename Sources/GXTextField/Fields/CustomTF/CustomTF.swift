//
//  CustomTF.swift
//  
//
//  Created by Anton Vlezko on 20.07.2021.
//

import Foundation
import SwiftUI

public struct CustomTF<LeadingContent, TrailingContent>: View, CustomTFButtonsProtocol, CustomTFInputProtocol where LeadingContent: View, TrailingContent: View {
    var inputType: CustomTFType
    var components: CustomTFComponents
    var leadingContent: () -> LeadingContent?
    var trailingContent: () -> TrailingContent?
    
    public init(
        inputType: CustomTFType,
        components: CustomTFComponents,
        @ViewBuilder leadingContent: @escaping () -> LeadingContent? = { nil },
        @ViewBuilder trailingContent: @escaping () -> TrailingContent? = { nil }
    ) {
        self.inputType = inputType
        self.components = components
        self.leadingContent = leadingContent
        self.trailingContent = trailingContent
    }
    
    public var body: some View {
        textfield
            .customTFActions(inputType: inputType,
                             textfield: components,
                             leadingContent: leadingContent,
                             trailingContent: trailingContent)
    }
    
    var textfield: some View {
        Group {
            switch inputType {
            case .standart(text: let text):
                standartField(text: text)
            case .decimal(totalInput: let totalInput,
                          currencySymbol: let currencySymbol):
                decimalField(totalInput: totalInput,
                             currencySymbol: currencySymbol)
            case .date(date: let date,
                       formatter: let formatter):
                dateField(date: date,
                          formatter: formatter)
            }
        }
    }
}

// MARK: - Init
public extension CustomTF {
    init(inputType: CustomTFType,
         components: CustomTFComponents) where LeadingContent == EmptyView, TrailingContent == EmptyView {
        self.init(
            inputType: inputType,
            components: components,
            leadingContent: {
                EmptyView()
            },
            trailingContent: {
                EmptyView()
            }
        )
    }
    
    init(inputType: CustomTFType,
         components: CustomTFComponents,
         @ViewBuilder trailingContent: @escaping () -> TrailingContent? ) where LeadingContent == EmptyView {
        self.init(
            inputType: inputType,
            components: components,
            leadingContent: {
                EmptyView()
            },
            trailingContent: trailingContent
        )
    }
    
    init(inputType: CustomTFType,
         components: CustomTFComponents,
         @ViewBuilder leadingContent: @escaping () -> LeadingContent?) where TrailingContent == EmptyView {
        self.init(
            inputType: inputType,
            components: components,
            leadingContent: leadingContent,
            trailingContent: {
                EmptyView()
            }
        )
    }
}

// MARK: - View Functions
extension CustomTF {
    func standartField(text: Binding<String>) -> some View {
        ZStack(alignment: .leading) {
            if text.wrappedValue.isEmpty {
                Text(components.placeholder)
            }
            
            if components.isShowSecureField {
                SecureField("",
                            text: text,
                            onCommit: components.commit)
                
            } else {
                TextField("",
                          text: text,
                          onEditingChanged: components.onChangeOfIsEditing,
                          onCommit: components.commit)
            }
        }
    }
    
    func decimalField(totalInput: Binding<Double?>, currencySymbol: String?) -> some View {
        ZStack(alignment: .leading) {
            if totalInput.wrappedValue.isNil {
                Text(components.placeholder)
            }
            DecimalTextField("",
                             value: totalInput,
                             alwaysShowFractions: components.alwaysShowFractions,
                             currencySymbol: currencySymbol,
                             onEditingChanged: components.onChangeOfIsEditing)
        }
    }
    
    func dateField(date: Binding<Date?>, formatter: DateFormatter?) -> some View {
        VStack {
            let format = formatter ?? .ddMMyyyy
            
            DateField(
                components.placeholder,
                date: date,
                formatter: format,
                minAge: 0,
                color: UIColor(components.textColor)
            )
        }
    }
}
