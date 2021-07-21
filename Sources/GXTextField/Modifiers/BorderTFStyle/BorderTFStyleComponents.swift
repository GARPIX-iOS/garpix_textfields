//
//  BorderTFStyleComponents.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

public struct BorderTFStyleComponents: BorderTFStyleProtocol {
    var text: String
    var title: String
    var image: String
    var type: BorderStyles
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
    var showLabelAfterEnteringText: Bool
    
    public init(
        text: String,
        title: String,
        image: String,
        type: BorderStyles,
        font: Font = .caption2,
        textColor: Color = Color(.label),
        strokeWidth: CGFloat = 1,
        strokeStandartColor: Color = Color(.gray),
        strokeSelectedColor: Color = Color(.label),
        strokeErrorColor: Color = Color(.red),
        cornerRadius: CGFloat = 10,
        offsetX: CGFloat = 10,
        offsetY: CGFloat = -8,
        backgroundColor: Color = Color(.systemBackground),
        showLabelAfterEnteringText: Bool = true
    ) {
        self.text = text
        self.title = title
        self.image = image
        self.type = type
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
        self.showLabelAfterEnteringText = showLabelAfterEnteringText
    }
}
