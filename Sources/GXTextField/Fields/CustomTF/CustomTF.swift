//
//  CustomTF.swift
//  
//
//  Created by Anton Vlezko on 20.07.2021.
//

import Foundation
import SwiftUI

// MARK: - Struct

/// This View takes as variable CustomTFComponents and provide mostly all functionality to textfield.
struct CustomTF: View {
    var components: CustomTFComponents
        
    var body: some View {
        textfield
            .customTFActions(textfield: components)
    }
}

// MARK: - CustomTF Views
extension CustomTF {
    
    /// That view manages wich view function we should apply depending on inputType
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

// MARK: - CustomTF View Functions
extension CustomTF {
    
    /// This function builds core functionality for textField with text input, it place Placeholder above field, show SecureField if you choose it and send onEdit data up to constructor
    /// - Parameter text: input text
    /// - Returns: TextField
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
    
    /// This function builds core functionality for textField with decimal input, it place Placeholder above field, send onEdit data up to constructor and configure DecimalTextField with components properties
    /// - Parameters:
    ///   - totalInput: input numbers
    ///   - currencySymbol: currency symbol provided by client if you pass nil there will be no symbol in the field. Yep if you think that symbol is at the wrong side pls check your locale
    /// - Returns: TextField
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
    
    /// This function builds core functionality for textField with date input, it place Placeholder above field, send onEdit data up to constructor and configure DateField with components properties
    /// - Parameters:
    ///   - date: if you pass optional date you will see just placeholder
    ///   - formatter: We provide different styles of formatter but you can use your own
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
                color: UIColor(components.textColor)
            )
        }
    }
}

// MARK: - CustomTF Helper Functions
extension CustomTF {
    
    /// This function sets isEditing to false if isEdit is false with animation
    /// - Parameter isEdit: Bool variable from textfield onEditingChanged
    func onEditingChanged(isEdit: Bool) {
        if !isEdit {
            withAnimation(.spring()) {
                components.isEditing = false
            }
        }
    }
}
