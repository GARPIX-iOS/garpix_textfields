//
//  DateField.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import UIKit
import SwiftUI

// MARK: - UIViewRepresentable

/// Текстфилд необходимый для обертки UIKit кода в SwiftUI
struct DateField: UIViewRepresentable {
    // MARK: - Public properties
    
    @Binding var date: Date?
    @Binding var isEdit: Bool
    var color: UIColor
    var placeholderColor: UIColor?
    let formatter: DateFormatter
    var minAge: Int
    var minDate: Date?
    var maxDate: Date?
    
    // MARK: - Private properties
    
    private var placeholder: String
    private var textField: KeyboardWithDatePicker
    
    // MARK: - Initializers
    
    init<S>(_ title: S,
            date: Binding<Date?>,
            isEdit: Binding<Bool>,
            formatter: DateFormatter = .ddMMyyyy,
            minAge: Int,
            minDate: Date? = nil,
            maxDate: Date? = nil,
            color: UIColor = .label,
            placeholderColor: UIColor? = nil) where S: StringProtocol
    {
        placeholder = String(title)
        _date = date
        _isEdit = isEdit
        self.color = color
        self.placeholderColor = placeholderColor
        self.formatter = formatter
        self.minAge = minAge
        self.minDate = minDate
        self.maxDate = maxDate
        
        textField = KeyboardWithDatePicker(
            date: date,
            isEdit: isEdit,
            color: placeholderColor ?? color,
            minAge: minAge,
            minDate: minDate,
            maxDate: maxDate
        )
    }
    
    // MARK: - UIViewRepresentable methods
    
    func makeUIView(context _: UIViewRepresentableContext<DateField>) -> UITextField {
        if let unwrappedDate = date {
            textField.placeholder = formatter.string(from: unwrappedDate)
        } else {
            textField.placeholder = placeholder
        }
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context _: UIViewRepresentableContext<DateField>) {
        if let unwrappedDate = date {
            uiView.text = formatter.string(from: unwrappedDate)
            uiView.textColor = color
        } else {
            uiView.text = placeholder
            uiView.textColor = placeholderColor ?? color
        }
    }
}

