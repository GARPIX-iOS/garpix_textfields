//
//  CustomTFActions.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

struct CustomTFActions: ViewModifier {
    var textfield: CustomTFComponents
    
    func body(content: Content) -> some View {
        textFieldView(content: content)
            .onTapGesture {
                withAnimation(.spring()) {
                    textfield.isEditing = true
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
            .gesture(DragGesture().onChanged { _ in
                textfield.hideKeyboard()
            })
    }
    
    func textFieldView(content: Content) -> some View {
        Group {
            switch textfield.inputType {
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
}

extension View {
    func customTFActions(textfield: CustomTFComponents) -> some View  {
        modifier(CustomTFActions(textfield: textfield))
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

public extension View {
    func onHideKeyboard(_ completion: @escaping () -> Void) -> some View {
        self
            .gesture(DragGesture().onChanged { _ in
                completion()
            })
    }
}
