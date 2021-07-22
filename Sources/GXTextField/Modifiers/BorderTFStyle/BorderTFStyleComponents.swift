//
//  BorderTFStyleComponents.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

public struct BorderTFStyleComponents: BorderTFStyleProtocol {
    @Binding var borderStyle: BorderStyles
    @Binding var showLabel: Bool
    var title: String
    var image: String
    var font: Font
    var textColor: Color
    var strokeWidth: CGFloat
    var strokeStandartColor: Color
    var strokeSelectedColor: Color
    var strokeErrorColor: Color
    var cornerRadius: CGFloat
    var offsetX: CGFloat
    var offsetY: CGFloat
    var backgroundColor: Color
    
    public init(
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
    ) {
        _borderStyle = borderStyle
        _showLabel = showLabel
        self.title = title
        self.image = image
        self.font = font
        self.textColor = textColor
        self.strokeWidth = strokeWidth
        self.strokeStandartColor = strokeStandartColor
        self.strokeSelectedColor = strokeSelectedColor
        self.strokeErrorColor = strokeErrorColor
        self.cornerRadius = cornerRadius
        self.offsetX = offsetX
        self.offsetY = offsetY
        self.backgroundColor = backgroundColor
    }
}
