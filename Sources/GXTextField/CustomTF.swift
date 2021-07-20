//
//  CustomTF.swift
//  
//
//  Created by Anton Vlezko on 20.07.2021.
//

import Foundation
import SwiftUI

protocol CustomTFProtocol {
    var text: String { get set }
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
    associatedtype SideContent: View
    
    var leadingButtons: () -> SideContent? { get set }
    var trailingButtons: () -> SideContent? { get set }
}

struct CustomTFComponents: CustomTFProtocol {
    var text: String
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
}

struct CustomTF<SideContent>: View, CustomTFButtonsProtocol where SideContent: View {
    @Binding var components: CustomTFComponents
    var leadingButtons: () -> SideContent?
    var trailingButtons: () -> SideContent?
    
    init(
        components: Binding<CustomTFComponents>,
        @ViewBuilder leadingButtons: @escaping () -> SideContent? = { nil },
        @ViewBuilder trailingButtons: @escaping () -> SideContent? = { nil }
    ) {
        _components = components
        self.leadingButtons = leadingButtons
        self.trailingButtons = trailingButtons
    }
    
    var body: some View {
        textfield
            .customTFActions(textfield: components,
                             leadingButtons: leadingButtons,
                             trailingButtons: trailingButtons)
    }
    
    var textfield: some View {
        ZStack(alignment: .leading) {
            if components.text.isEmpty {
                Text(components.placeholder)
            }
            
            if components.isShowSecureField {
                SecureField("", text: $components.text, onCommit: components.commit)
                
            } else {
                TextField("", text: $components.text, onEditingChanged: components.onChangeOfIsEditing, onCommit: components.commit)
            }
        }
    }
}

extension CustomTF {
    init(components: Binding<CustomTFComponents>) where SideContent == Color {
        self.init(
            components: components,
            leadingButtons: {
                Color.primary
            },
            trailingButtons: {
                Color.primary
            }
        )
    }
}

struct CustomTFActions<SideContent>: ViewModifier, CustomTFButtonsProtocol where SideContent: View{
    var textfield: CustomTFComponents
    var leadingButtons: () -> SideContent?
    var trailingButtons: () -> SideContent?
    
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
                .onChange(of: textfield.text, perform: { value in
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
    var trailingButtonsView: some View {
        if textfield.isShowTrailingButtons {
            trailingButtons()
                .padding(.trailing, 16)
        }
    }
    
    @ViewBuilder
    var leadingButtonsView: some View {
        if textfield.isShowLeadingButtons {
            leadingButtons()
                .padding(.leading, 16)
        }
    }
}

extension View {
    func customTFActions<SideContent: View>(textfield: CustomTFComponents,
                                            leadingButtons: @escaping () -> SideContent?,
                                            trailingButtons: @escaping () -> SideContent?) -> some View {
        modifier(CustomTFActions(textfield: textfield,
                                 leadingButtons: leadingButtons,
                                 trailingButtons: trailingButtons))
    }
}
