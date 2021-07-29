//
//  BorderTFStyle + Extension.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

public extension View {
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
            title: title,
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
