//
//  TextFieldBorderStyle.swift
//  Red
//
//  Created by Danil Lomaev on 26.03.2021.
//

import Foundation
import SwiftUI

public enum BorderStyles {
    case standart
    case selected
    case error
}

protocol TextFieldBorderStyleProtocol {
    var title: String { get set }
    var image: String { get set }
    var font: Font { get set }
    var textColor: Color { get set }
    var strokeWidth: CGFloat { get set }
    var strokeStandartColor: Color { get set }
    var strokeSelectedColor: Color { get set }
    var strokeErrorColor: Color { get set }
    var cornerRadius: CGFloat { get set }
    var offsetX: CGFloat { get set }
    var offsetY: CGFloat { get set }
    var backgroundColor: Color { get set }
    var type: BorderStyles { get set }
    
    // MARK: - All properties init
    
    init(
        title: String,
        image: String,
        type: BorderStyles,
        font: Font,
        textColor: Color,
        strokeWidth: CGFloat,
        strokeStandartColor: Color,
        strokeSelectedColor: Color,
        strokeErrorColor: Color,
        cornerRadius: CGFloat,
        offsetX: CGFloat,
        offsetY: CGFloat,
        backgroundColor: Color
    )
}

// MARK: - Helper Functions
extension TextFieldBorderStyleProtocol {
    func strokeColorCalculator() -> Color {
        switch type {
        case .standart: return strokeStandartColor
        case .selected: return strokeSelectedColor
        case .error: return strokeErrorColor
        }
    }
}

struct TextFieldBorderStyle: ViewModifier, TextFieldBorderStyleProtocol {
    var title: String
    var image: String
    var font: Font
    var textColor: Color
    var strokeWidth: CGFloat
    var strokeStandartColor: Color
    var strokeSelectedColor: Color
    var strokeErrorColor: Color
    var cornerRadius: CGFloat
    var backgroundColor: Color
    var offsetX: CGFloat
    var offsetY: CGFloat
    var type: BorderStyles
    
    init(
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
        backgroundColor: Color = Color(.systemBackground)
    ) {
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
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ZStack(alignment: .topLeading) {
                    Group {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(strokeColorCalculator(),
                                    lineWidth: strokeWidth)
                        if !title.isEmpty {
                            HStack {
                                Text(title)
                                    .font(font)
                                if !image.isEmpty {
                                    Image(systemName: image)
                                }
                            }
                            .font(font)
                            .foregroundColor(textColor)
                            .padding(2)
                            .background(backgroundColor)
                            .offset(x: offsetX, y: offsetY)
                        }
                    }
                }
            )
    }
}

extension View {
    func textFieldBorderStyle(type: BorderStyles,
                              title: String,
                              image: String) -> some View {
        modifier(TextFieldBorderStyle(
            title: title,
            image: image,
            type: type
        ))
    }
}
