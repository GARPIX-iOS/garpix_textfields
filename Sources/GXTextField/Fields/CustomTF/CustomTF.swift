//
//  CustomTF.swift
//  
//
//  Created by Anton Vlezko on 20.07.2021.
//

import Foundation
import SwiftUI

// MARK: - Struct

/// Эта View принимает в качестве переменных CustomTFComponents и предоставляет основной функционал для TF
struct CustomTF: View {
    var components: CustomTFComponents
        
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            textfield
                .customTFActions(textfield: components)
        }

    }
}

// MARK: - CustomTF Views
extension CustomTF {
    /// Эта View  определяет, какую функцию представления мы должны применять в зависимости от inputType
    
    @ViewBuilder
    var textfield: some View {
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


extension CustomTF {
    func createStandartToolBar(by textfield: UITextField) {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textfield.frame.size.width, height: 44))
        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Ok", style: .done, target: self, action: #selector(textfield.doneButtonTapped(button:)))
        doneButton.tintColor = .systemBlue
        toolBar.items = [flexButton, doneButton]
        toolBar.setItems([flexButton, doneButton], animated: true)
        textfield.inputAccessoryView = toolBar
    }
}

// MARK: - CustomTF View Functions
extension CustomTF {
    /// Эта функция создает базовую функциональность для TF с вводом текста, она заменяет поле Placeholder над полем, показывает SecureField, если вы его выберете, и отправляет данные onEdit в конструктор
    /// - Parameter text: input text
    /// - Returns: TextField
    func standartField(text: Binding<String>) -> some View {
        ZStack(alignment: .leading) {
            if text.wrappedValue.isEmpty {
                Text(components.placeholder)
                    .font(components.placeholderFont)
                    .foregroundColor(components.placeholderColor)
            }
            
            if components.isShowSecureField {
                SecureField("",
                            text: text,
                            onCommit: components.commit)
                    .introspectTextField(customize: { tf in
                        guard components.isShowToolbar else { return }
                        if components.toolBarViewCallback != nil {
                            components.toolBarViewCallback!(tf)
                        } else {
                            createStandartToolBar(by: tf)
                        }

                    })
                
            } else {
                TextField("",
                          text: text,
                          onEditingChanged: { isEdit in
                            onEditingChanged(isEdit: isEdit)
                          },
                          onCommit: components.commit)
                    .introspectTextField(customize: { tf in
                        guard components.isShowToolbar else { return }
                        if components.toolBarViewCallback != nil {
                            components.toolBarViewCallback!(tf)
                        } else {
                            createStandartToolBar(by: tf)
                        }

                    })
            }
        }
    }
    
    /// Эта функция создает базовую функциональность для textField с Double, она помещает заполнитель над полем, отправляет данные onEdit в конструктор и настраивает DecimalTextField со свойствами компонентов
    /// - Parameters:
    ///   - totalInput: вводные числа
    ///   - currencySymbol: символ валюты, предоставленный пользователем, если вы передадите nil, в поле не будет символа. Да и есле так вышло, что этот символ находится не на той стороне, пожалуйста, проверьте locale
    /// - Returns: TextField
    func decimalField(totalInput: Binding<Double?>, currencySymbol: String?) -> some View {
        ZStack(alignment: .leading) {
            if totalInput.wrappedValue.isNil {
                Text(components.placeholder)
                    .foregroundColor(components.placeholderColor)
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
    /// Эта функция создает базовую функциональность для textField с вводом даты, она заменяет поле Placeholder над полем, отправляет данные onEdit в конструктор и настраивает DateField со свойствами компонентов
    /// - Parameters:
    ///   - date: если вы введете опциональную дату, вы увидите просто заполнитель
    ///   - formatter: мы предоставляем разные стили форматировщика, но вы можете использовать свои собственные
    /// - Returns: TextField
    func dateField(date: Binding<Date?>, formatter: DateFormatter?) -> some View {
        VStack {
            let format = formatter ?? .ddMMyyyy
            
            DateField(
                components.placeholder,
                date: date,
                isEdit: components.$isEditing,
                formatter: format,
                minAge: 0,
                color: UIColor(components.textColor),
                placeholderColor: UIColor(components.placeholderColor ?? components.textColor)
            )
        }
    }
}

// MARK: - CustomTF Helper Functions
extension CustomTF {
    /// Эта функция устанавливает для isEditing значение false, с анимацией
    /// - Parameter isEdit: переменная типа Bool из текстового поля onEditingChanged
    func onEditingChanged(isEdit: Bool) {
        if !isEdit {
            withAnimation(.spring()) {
                components.isEditing = false
            }
        }
    }
}
