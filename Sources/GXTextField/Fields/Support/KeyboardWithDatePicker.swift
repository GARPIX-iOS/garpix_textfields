//
//  KeyboardWithDatePicker.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import Foundation
import SwiftUI
import UIKit

// MARK: - class

/// Класс позволяющий отображать пикер даты вместо клавиатуры
class KeyboardWithDatePicker: UITextField {
    @Binding var date: Date?
    @Binding var isEdit: Bool
    var color: UIColor
    var minAge: Int
    var minDate: Date?
    var maxDate: Date?

    init(date: Binding<Date?>,
         isEdit: Binding<Bool>,
         color: UIColor,
         minAge: Int,
         minDate: Date?,
         maxDate: Date?)
    {
        self.color = color
        _date = date
        _isEdit = isEdit
        self.minAge = minAge
        self.minDate = minDate
        self.maxDate = maxDate
        super.init(frame: .zero)
        if date.wrappedValue != Date() {
            datePickerView.date = date.wrappedValue ?? Date()
        }
        var components = DateComponents()
        components.year = -minAge
        datePickerView.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        inputView = datePickerView
        let bar = UIToolbar()
        let reset = UIBarButtonItem(title: "Ок", style: .plain, target: self, action: #selector(resetTapped))
        bar.items = [reset]
        bar.sizeToFit()
        inputAccessoryView = bar
        tintColor = .clear
        textColor = color
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var datePickerView: UIDatePicker = {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.maximumDate = maxDate
        datePickerView.minimumDate = minDate
        return datePickerView
    }()

    @objc func dateChanged(_ sender: UIDatePicker) {
        date = sender.date
    }

    @objc func resetTapped(_: UITextField) {
        isEdit = false
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
