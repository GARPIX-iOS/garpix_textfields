//
//  PlainTextFieldProtocol.swift
//  Red
//
//  Created by Admin on 10.06.2021.
//

import SwiftUI

protocol PlainTextFieldProtocol: TextFieldPropertiesProtocol {
    associatedtype TrailingButtons: View

    var text: String { get set }
    var trailingButtons: TrailingButtons { get set }

    // Properties not required to initialize
    var showDeleteButton: Bool { get set }
    var onlyNumbers: Bool { get set }

    // Local properties
    var validSymbolsAmount: Int? { get set }

    init(text: Binding<String>,
         borderStyle: Binding<BorderStyles>,
         isEditing: Binding<Bool>,
         trailingButtons: TrailingButtons,
         image: Binding<String>,
         label: String,
         placeholder: String,
         width: CGFloat,
         showLabelAfterEnteringText: Bool,
         showDeleteButton: Bool,
         onlyNumbers: Bool)
}
