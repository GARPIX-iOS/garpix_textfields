//
//  CustomTFActions.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

struct CustomTFActions<LeadingContent, TrailingContent>: ViewModifier, CustomTFButtonsProtocol where LeadingContent: View, TrailingContent: View {
    @Binding var text: String
    var textfield: CustomTFComponents
    var leadingContent: () -> LeadingContent?
    var trailingContent: () -> TrailingContent?
    
    func body(content: Content) -> some View {
        HStack(spacing: 10) {
            leadingButtonsView
            
            content
                .keyboardType(textfield.onlyNumbers ? .numberPad : textfield.keyboardType)
                .onTapGesture {
                    withAnimation(.spring()) {
                        textfield.onTap()
                    }
                }
                .font(.callout)
                .onChange(of: text, perform: { value in
                    textfield.limitTextLength(text: text,
                                              validSymbolsAmount: textfield.validSymbolsAmount,
                                              onlyNumbers: textfield.onlyNumbers)
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
