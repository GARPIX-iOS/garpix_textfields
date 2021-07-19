//
//  TextFieldStyle.swift
//  Red
//
//  Created by Admin on 10.06.2021.
//

import SwiftUI

struct TextFieldStyleComponents<TrailingButtons: View> {
    var text: String
    var borderStyle: BorderStyles
    var isEditing: Bool
    var trailingButtons: TrailingButtons

    var image: String
    var label: String
    var width: CGFloat

    var keyboardType: UIKeyboardType
    var showDeleteButton: Bool

    var onTap: () -> Void
    var onChangeOfText: (String) -> Void
    var onChangeOfIsEditing: (Bool) -> Void
    var deleteTapped: () -> Void
    var hideKeyboard: () -> Void
}

struct TextFieldStyle<TrailingButtons: View>: ViewModifier {
    var components: TextFieldStyleComponents<TrailingButtons>

    func body(content: Content) -> some View {
        HStack(spacing: 10) {
            content
                .keyboardType(components.keyboardType)
                .onTapGesture {
                    withAnimation(.spring()) {
                        components.onTap()
                    }
                }
                .font(.callout)
                .onChange(of: components.text, perform: { value in
                    components.onChangeOfText(value)
                })
                .onChange(of: components.isEditing, perform: { value in
                    components.onChangeOfIsEditing(value)
                })
                .padding(.vertical)
                .padding(.trailing)
                .padding(.leading, 12)

            if components.isEditing {
                HStack {
                    if components.showDeleteButton, components.text != "" {
                        Button(
                            action: { components.deleteTapped() },
                            label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.black)
                                    .frame(width: 15, height: 15, alignment: .center)
                            }
                        )
                    }
                    components.trailingButtons
                        .trailingButtonsStyle()
                }
                .padding(.trailing, 16)
            }
        }
        .frame(width: components.width, height: 60, alignment: .center)
        .textFieldBorderStyle(type: components.borderStyle, title: components.label, image: components.image)
        .gesture(DragGesture().onChanged { _ in
            components.hideKeyboard()
        })
    }
}
