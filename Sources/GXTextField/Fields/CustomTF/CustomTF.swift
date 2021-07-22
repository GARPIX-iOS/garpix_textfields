//
//  CustomTF.swift
//  
//
//  Created by Anton Vlezko on 20.07.2021.
//

import Foundation
import SwiftUI

public struct CustomTF<LeadingContent, TrailingContent>: View, CustomTFButtonsProtocol where LeadingContent: View, TrailingContent: View {
    var components: CustomTFComponents
    var leadingContent: () -> LeadingContent?
    var trailingContent: () -> TrailingContent?
    
    public init(
        components: CustomTFComponents,
        @ViewBuilder leadingContent: @escaping () -> LeadingContent? = { nil },
        @ViewBuilder trailingContent: @escaping () -> TrailingContent? = { nil }
    ) {
        self.components = components
        self.leadingContent = leadingContent
        self.trailingContent = trailingContent
    }
    
    public var body: some View {
        textfield
            .customTFActions(inputType: components.inputType,
                             textfield: components,
                             leadingContent: leadingContent,
                             trailingContent: trailingContent)
    }
    
    var textfield: some View {
        Group {
            switch components.inputType {
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
    init(components: CustomTFComponents) where LeadingContent == EmptyView, TrailingContent == EmptyView {
        self.init(
            components: components,
            leadingContent: {
                EmptyView()
            },
            trailingContent: {
                EmptyView()
            }
        )
    }
    
    init(components: CustomTFComponents,
         @ViewBuilder trailingContent: @escaping () -> TrailingContent? ) where LeadingContent == EmptyView {
        self.init(
            components: components,
            leadingContent: {
                EmptyView()
            },
            trailingContent: trailingContent
        )
    }
    
    init(components: CustomTFComponents,
         @ViewBuilder leadingContent: @escaping () -> LeadingContent?) where TrailingContent == EmptyView {
        self.init(
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
                          onEditingChanged: { isEdit in
                            onEditingChanged(isEdit: isEdit)
                          },
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
                             onEditingChanged: { isEdit in
                               onEditingChanged(isEdit: isEdit)
                             })
        }
    }
    
    func dateField(date: Binding<Date?>, formatter: DateFormatter?) -> some View {
        VStack {
            let format = formatter ?? .ddMMyyyy
            
            DateField(
                components.placeholder,
                date: date,
                isEdit: components.$isEditing,
                formatter: format,
                minAge: 0,
                color: UIColor(components.textColor)
            )
        }
    }
}

// MARK: - Helper Functions
extension CustomTF {
    func onEditingChanged(isEdit: Bool) {
        if !isEdit {
            withAnimation(.spring()) {
                components.isEditing = false
            }
        }
    }
}
