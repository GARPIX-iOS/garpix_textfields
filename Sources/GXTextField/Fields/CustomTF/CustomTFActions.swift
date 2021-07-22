//
//  CustomTFActions.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

struct CustomTFActions<LeadingContent, TrailingContent>: ViewModifier, CustomTFButtonsProtocol, CustomTFInputProtocol where LeadingContent: View, TrailingContent: View {
    var inputType: CustomTFType
    var textfield: CustomTFComponents
    var leadingContent: () -> LeadingContent?
    var trailingContent: () -> TrailingContent?
    
    func body(content: Content) -> some View {
        HStack(spacing: 10) {
            leadingButtonsView
        
            textFieldView(content: content)
                .onTapGesture {
                    withAnimation(.spring()) {
                        textfield.onTap()
                    }
                }
                .font(.callout)
                .onChange(of: textfield.isEditing, perform: { value in
                    textfield.onChangeOfIsEditing(value)
                })
                .padding(.vertical)
                .padding(.trailing)
                .padding(.leading, 12)
                .foregroundColor(textfield.textColor)
            
            trailingButtonsView
            
        }
        .frame(width: textfield.width, height: textfield.height, alignment: .center)
        .gesture(DragGesture().onChanged { _ in
            textfield.hideKeyboard()
        })
    }
    
    func textFieldView(content: Content) -> some View {
        Group {
            switch inputType {
            case .standart(text: let text):
                content
                    .onChangeOfText(text: text, textfield: textfield)
                    .keyboardType(textfield.onlyNumbers ? .numberPad : textfield.keyboardType)
            case .decimal(totalInput: let totalInput, currencySymbol: let currencySymbol):
                content
                    .keyboardType(textfield.onlyNumbers ? .numberPad : textfield.keyboardType)
            case .date(date: let date, formatter: let formatter):
                content
            }
        }
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
    func customTFActions<LeadingContent: View, TrailingContent: View>(inputType: CustomTFType,
                                                                      textfield: CustomTFComponents,
                                                                      leadingContent: @escaping () -> LeadingContent?,
                                                                      trailingContent: @escaping () -> TrailingContent?) -> some View  {
        modifier(CustomTFActions(inputType: inputType,
                                 textfield: textfield,
                                 leadingContent: leadingContent,
                                 trailingContent: trailingContent))
    }
}

struct OnChangeOfText: ViewModifier {
    @Binding var text: String
    var textfield: CustomTFComponents
    
    func body(content: Content) -> some View {
        content
            .onChange(of: text, perform: { value in
                text = textfield.formatText(text: text,
                                            textFormat: textfield.textFormat,
                                            validSymbolsAmount: textfield.validSymbolsAmount,
                                            onlyNumbers: textfield.onlyNumbers)
                textfield.onChangeOfText(value)
            })
    }
}

extension View {
    func onChangeOfText(text: Binding<String>, textfield: CustomTFComponents) -> some View {
        modifier(OnChangeOfText(text: text,
                                textfield: textfield))
    }
}
