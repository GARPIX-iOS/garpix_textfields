//
//  CustomTFActions.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

// MARK: - Struct

/// Those ViewModifier provides functionality to track changes of input added to text field and pass it back in completion block to work with them from constructor
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
    
    
    /// Service func works with different input types. Mostly needed to track changes of text and pass them back. I left other input types becouse we will add some functionality to them later i guess
    func textFieldView(content: Content) -> some View {
        Group {
            switch textfield.inputType {
            case .standart(text: let text):
                content
                    .onChangeOfText(text: text, textfield: textfield)
                    .keyboardType(textfield.onlyNumbers ? .numberPad : textfield.keyboardType)
            case .decimal(totalInput: _, currencySymbol: _):
                content
                    .keyboardType(textfield.onlyNumbers ? .numberPad : textfield.keyboardType)
            case .date(date: _, formatter: _):
                content
            }
        }
    }
}


/// Those ViewModifier needed to track onChange of text when StandartTextField with String input is chosen
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

// MARK: - View extension for onHideKeyboard

public extension View {
    /// This method provide simular functionality as hideKeyboard() method it needs when you whant to do smth in completion after keyboard hides
    func onHideKeyboard(_ completion: @escaping () -> Void) -> some View {
        self
            .gesture(DragGesture().onChanged { _ in
                completion()
            })
    }
}

// MARK: - View extension for customTFActions

extension View {
    /// This method is needed to apply all tracking functionality on CustomTF
    func customTFActions(textfield: CustomTFComponents) -> some View  {
        modifier(CustomTFActions(textfield: textfield))
    }
}

// MARK: - View extension for onChangeOfText

extension View {
    /// This method needed to pass tracking data about changed text up to constructor
    func onChangeOfText(text: Binding<String>, textfield: CustomTFComponents) -> some View {
        modifier(OnChangeOfText(text: text,
                                textfield: textfield))
    }
}


