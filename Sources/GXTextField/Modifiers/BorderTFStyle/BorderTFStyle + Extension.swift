//
//  BorderTFStyle + Extension.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

// MARK: - View extension for borderTFStyle

public extension View {
    /// Этот метод необходим для применения изменений стиля к TF. Я предварительно установил некоторые переменные, но вы можете их изменить
    /// Этот метод необходим для применения изменений стиля к TF.
    /// ```
    /// @State private var text: String = ""
    /// @State private var textBorderStyle: BorderStyles = BorderStyles.standart
    /// @State private var textIsEditing: Bool = false
    ///
    /// var body: some View {
    ///     StandartTextField(
    ///         text: $text,
    ///         isEditing: $textIsEditing,
    ///         placeholder: placeholder
    ///     )
    ///     .borderTFStyle(
    ///           borderStyle: $cardNumberBorderStyle,
    ///           showLabel: $textIsEditing,
    ///           title: placeholder,
    ///           image: "chevron.left",
    ///           textColor: .red
    ///     ) // output -> View с примененным на нем стилем
    /// }
    /// ```
    /// - Returns: View с примененным стилем
    func borderTFStyle(
        borderStyle: Binding<BorderStyles>,
        showLabel: Binding<Bool>,
        title: String,
        image: String,
        font: Font = .caption2,
        textColor: Color = Color(.label),
        strokeWidth: CGFloat = 1,
        strokeStandartColor: Color = Color(.gray),
        strokeSelectedColor: Color = Color(.label),
        strokeErrorColor: Color = Color(.red),
        cornerRadius: CGFloat = 10,
        offsetX: CGFloat = 10,
        offsetY: CGFloat = -8,
        backgroundColor: Color = Color(.systemBackground)
    ) -> some View {
        let components = BorderTFStyleComponents(
            borderStyle: borderStyle,
            showLabel: showLabel,
            text: title,
            image: image,
            font: font,
            textColor: textColor,
            strokeWidth: strokeWidth,
            strokeStandartColor: strokeStandartColor,
            strokeSelectedColor: strokeSelectedColor,
            strokeErrorColor: strokeErrorColor,
            cornerRadius: cornerRadius,
            offsetX: offsetX,
            offsetY: offsetY,
            backgroundColor: backgroundColor
        )
        return modifier(BorderTFStyle(components: components))
    }
}
