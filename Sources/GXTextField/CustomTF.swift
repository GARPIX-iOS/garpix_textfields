//
//  CustomTF.swift
//  
//
//  Created by Anton Vlezko on 20.07.2021.
//

import Foundation
import SwiftUI

protocol CustomTFProtocol {
    var isEditing: Bool { get set }
    var placeholder: String { get set }
    var width: CGFloat { get set }
    var height: CGFloat { get set }
    var keyboardType: UIKeyboardType { get set }
    var isShowSecureField: Bool { get set }
    var isShowLeadingButtons: Bool { get set }
    var isShowTrailingButtons: Bool { get set }
    
    var onTap: () -> Void { get set }
    var onChangeOfText: (String) -> Void { get set }
    var onChangeOfIsEditing: (Bool) -> Void { get set }
    var commit: () -> Void { get set }
    var hideKeyboard: () -> Void { get set }
}

protocol CustomTFButtonsProtocol {
    associatedtype LeadingContent: View
    associatedtype TrailingContent: View
    
    var leadingContent: () -> LeadingContent? { get set }
    var trailingContent: () -> TrailingContent? { get set }
}

public struct CustomTFComponents: CustomTFProtocol {
    var isEditing: Bool
    var placeholder: String
    var width: CGFloat
    var height: CGFloat
    var keyboardType: UIKeyboardType
    var isShowSecureField: Bool
    var isShowLeadingButtons: Bool
    var isShowTrailingButtons: Bool
    
    var commit: () -> Void
    var onTap: () -> Void
    var onChangeOfText: (String) -> Void
    var onChangeOfIsEditing: (Bool) -> Void
    var hideKeyboard: () -> Void
    
    public init(
        isEditing: Bool = false,
        placeholder: String = "",
        width: CGFloat = Display.width * 0.9,
        height: CGFloat = 60,
        keyboardType: UIKeyboardType = .default,
        isShowSecureField: Bool = false,
        isShowLeadingButtons: Bool = false,
        isShowTrailingButtons: Bool = false,
        commit: @escaping () -> Void = {},
        onTap: @escaping () -> Void = {},
        onChangeOfText: @escaping (String) -> Void = {_ in},
        onChangeOfIsEditing: @escaping (Bool) -> Void = {_ in},
        hideKeyboard: @escaping () -> Void = {}
    ) {
        self.isEditing = isEditing
        self.placeholder = placeholder
        self.width = width
        self.height = height
        self.keyboardType = keyboardType
        self.isShowSecureField = isShowSecureField
        self.isShowLeadingButtons = isShowLeadingButtons
        self.isShowTrailingButtons = isShowTrailingButtons
        self.commit = commit
        self.onTap = onTap
        self.onChangeOfText = onChangeOfText
        self.onChangeOfIsEditing = onChangeOfIsEditing
        self.hideKeyboard = hideKeyboard
    }
}

public struct CustomTF<LeadingContent, TrailingContent>: View, CustomTFButtonsProtocol where LeadingContent: View, TrailingContent: View {
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

struct CustomTFActions<LeadingContent, TrailingContent>: ViewModifier, CustomTFButtonsProtocol where LeadingContent: View, TrailingContent: View {
    @Binding var text: String
    var textfield: CustomTFComponents
    var leadingContent: () -> LeadingContent?
    var trailingContent: () -> TrailingContent?
    
    func body(content: Content) -> some View {
        HStack(spacing: 10) {
            leadingButtonsView
            
            content
                .keyboardType(textfield.keyboardType)
                .onTapGesture {
                    withAnimation(.spring()) {
                        textfield.onTap()
                    }
                }
                .font(.callout)
                .onChange(of: text, perform: { value in
                    textfield.onChangeOfText(value)
                })
                .onChange(of: textfield.isEditing, perform: { value in
                    textfield.onChangeOfIsEditing(value)
                })
                .padding(.vertical)
                .padding(.trailing)
                .padding(.leading, 12)
            
            trailingButtonsView
            
        }
        .frame(width: textfield.width, height: textfield.height, alignment: .center)
        .gesture(DragGesture().onChanged { _ in
            textfield.hideKeyboard()
        })
    }
    
    @ViewBuilder
    var leadingButtonsView: some View {
        if textfield.isShowLeadingButtons {
            leadingContent()
                .padding(.leading, 16)
        }
    }
    
    @ViewBuilder
    var trailingButtonsView: some View {
        if textfield.isShowTrailingButtons {
            trailingContent()
                .padding(.trailing, 16)
        }
    }
}

extension View {
    func customTFActions<LeadingContent: View, TrailingContent: View>(text: Binding<String>,
                                                                      textfield: CustomTFComponents,
                                                                      leadingContent: @escaping () -> LeadingContent?,
                                                                      trailingContent: @escaping () -> TrailingContent?) -> some View  {
        modifier(CustomTFActions(text: text,
                                 textfield: textfield,
                                 leadingContent: leadingContent,
                                 trailingContent: trailingContent))
    }
}
