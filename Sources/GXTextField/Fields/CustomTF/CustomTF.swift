//
//  CustomTF.swift
//  
//
//  Created by Anton Vlezko on 20.07.2021.
//

import Foundation
import SwiftUI

public struct CustomTF<LeadingContent, TrailingContent>: View, CustomTFButtonsProtocol where LeadingContent: View, TrailingContent: View {
    
//    var inputType: CustomTFType
    
    @Binding var text: String
    var components: CustomTFComponents
    var leadingContent: () -> LeadingContent?
    var trailingContent: () -> TrailingContent?
    
    public init(
        text: Binding<String>,
        components: CustomTFComponents,
        @ViewBuilder leadingContent: @escaping () -> LeadingContent? = { nil },
        @ViewBuilder trailingContent: @escaping () -> TrailingContent? = { nil }
    ) {
        _text = text
        self.components = components
        self.leadingContent = leadingContent
        self.trailingContent = trailingContent
    }
    
    public var body: some View {
        textfield
            .customTFActions(text: $text,
                             textfield: components,
                             leadingContent: leadingContent,
                             trailingContent: trailingContent)
    }
    
    var textfield: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(components.placeholder)
            }
            
            if components.isShowSecureField {
                SecureField("", text: $text, onCommit: components.commit)
                
            } else {
                TextField("", text: $text, onEditingChanged: components.onChangeOfIsEditing, onCommit: components.commit)
            }
        }
    }
}

// MARK: - Init
public extension CustomTF {
    init(text: Binding<String>,
         components: CustomTFComponents) where LeadingContent == EmptyView, TrailingContent == EmptyView {
        self.init(
            text: text,
            components: components,
            leadingContent: {
                EmptyView()
            },
            trailingContent: {
                EmptyView()
            }
        )
    }
    
    init(text: Binding<String>,
         components: CustomTFComponents,
         @ViewBuilder trailingContent: @escaping () -> TrailingContent? ) where LeadingContent == EmptyView {
        self.init(
            text: text,
            components: components,
            leadingContent: {
                EmptyView()
            },
            trailingContent: trailingContent
        )
    }

    init(text: Binding<String>,
         components: CustomTFComponents,
         @ViewBuilder leadingContent: @escaping () -> LeadingContent?) where TrailingContent == EmptyView {
        self.init(
            text: text,
            components: components,
            leadingContent: leadingContent,
            trailingContent: {
                EmptyView()
            }
        )
    }
}
