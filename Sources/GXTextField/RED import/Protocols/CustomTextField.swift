//
//  CustomTextField.swift
//  Red
//
//  Created by Admin on 10.06.2021.
//

import SwiftUI

protocol CustomTextFieldProtocol: View {
    var placeholder: String { get set }
    var text: String { get set }
    var editingChanged: (Bool) -> Void { get set }
    var commit: () -> Void { get set }
    // only for password textfield
    var isShowPassword: Bool { get set }
}

//extension CustomTextFieldProtocol {
//    func textFieldStyle(components: TextFieldStyleComponents<TrailingButtons>) -> some View {
//        return modifier(TextFieldStyle(components: components))
//    }
//}

extension View {
    func textFieldStyle<TrailingButtons: View>(components: TextFieldStyleComponents<TrailingButtons>) -> some View {
        return modifier(TextFieldStyle<TrailingButtons>(components: components))
    }
}

struct CustomTextField: View, CustomTextFieldProtocol {
    var placeholder: String
    @Binding var text: String
    var editingChanged: (Bool) -> Void = { _ in }
    var commit: () -> Void = {}
    // only for password textfield
    var isShowPassword: Bool = true

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
            }

            if isShowPassword {
                TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
            } else {
                SecureField("", text: $text, onCommit: commit)
            }
        }
    }
}
