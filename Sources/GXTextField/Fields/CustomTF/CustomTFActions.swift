//
//  CustomTFActions.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

// MARK: - Struct

/// Эти ViewModifier предоставляют функции для отслеживания изменений ввода, добавленного в текстовое поле, и передачи его обратно в блок завершения для работы с ними из конструктора
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
    
    /// Сервисная функция работает с разными типами ввода. В основном необходимо, чтобы отслеживать изменения текста и передавать их обратно. Я оставил другие типы ввода, потому что мы добавим к ним некоторые функции позже, я думаю
    func textFieldView(content: Content) -> some View {
        Group {
            switch textfield.inputType {
            case .standart(text: let text):
                content
                    .onChangeOfText(text: text, textfield: textfield)
                    .keyboardType(textfield.keyboardType)
            case .decimal(totalInput: _, currencySymbol: _):
                content
                    .keyboardType(textfield.keyboardType)
            case .date(date: _, formatter: _):
                content
            }
        }
    }
}


/// Те ViewModifier, необходимые для отслеживания изменения текста при выборе StandartTextField с вводом String
struct OnChangeOfText: ViewModifier {
    @Binding var text: String
    var textfield: CustomTFComponents
    
    func body(content: Content) -> some View {
        content
            .onChange(of: text, perform: { value in
                text = textfield.formatText(text: text,
                                            textFormat: textfield.formatType?.textFormat,
                                            validSymbolsAmount: textfield.formatType?.validSymbolsAmount,
                                            inputType: textfield.formatType?.inputType)
                
                textfield.formatType?.onChangeOfText(value)
            })
    }
}

// MARK: - View extension for onHideKeyboard

public extension View {
    /// Этот метод обеспечивает аналогичную функциональность, как метод hideKeyboard (), который ему нужен, когда вы хотите выполнить что-то в завершении после того, как клавиатура скрывается
    func onHideKeyboard(_ completion: @escaping () -> Void) -> some View {
        self
            .gesture(DragGesture().onChanged { _ in
                completion()
            })
    }
}

// MARK: - View extension for customTFActions

extension View {
    /// Этот метод необходим для применения всех функций отслеживания на CustomTF
    func customTFActions(textfield: CustomTFComponents) -> some View  {
        modifier(CustomTFActions(textfield: textfield))
    }
}

// MARK: - View extension for onChangeOfText

extension View {
    /// Этот метод нужен для передачи данных отслеживания измененного текста в конструктор
    func onChangeOfText(text: Binding<String>, textfield: CustomTFComponents) -> some View {
        modifier(OnChangeOfText(text: text,
                                textfield: textfield))
    }
}


