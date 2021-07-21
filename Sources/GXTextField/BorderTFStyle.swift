//
//  File.swift
//  
//
//  Created by Anton Vlezko on 20.07.2021.
//

import Foundation
import SwiftUI

public enum BorderStyles {
    case standart
    case selected
    case error
}

protocol BorderTFStyleProtocol {
    var title: String { get set }
    var image: String { get set }
    var type: BorderStyles { get set }
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
    var showLabelAfterEnteringText: Bool { get set }
    
}

// MARK: - Helper Functions
extension BorderTFStyleProtocol {
    func strokeColorCalculator() -> Color {
        switch type {
        case .standart: return strokeStandartColor
        case .selected: return strokeSelectedColor
        case .error: return strokeErrorColor
        }
    }
}

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

public struct BorderTFStyle: ViewModifier {
    var components: BorderTFStyleComponents
    
    public func body(content: Content) -> some View {
        content
            .overlay(
                ZStack(alignment: .topLeading) {
                    Group {
                        RoundedRectangle(cornerRadius: components.cornerRadius)
                            .stroke(components.strokeColorCalculator(),
                                    lineWidth: components.strokeWidth)
                            HStack {
                                Text(labelCalculator(text: components.text))
                                    .font(components.font)
                                if !components.image.isEmpty, !components.text.isEmpty {
                                    Image(systemName: components.image)
                                }
                            }
                            .font(components.font)
                            .foregroundColor(components.textColor)
                            .padding(paddingCalc())
                            .background(components.backgroundColor)
                            .offset(x: components.offsetX, y: components.offsetY)
                    }
                }
            )
    }
}

// MARK: - Helper Functions
extension BorderTFStyle {
    func labelCalculator(text: String) -> String {
        withAnimation(.easeOut(duration: 0.3)) {
            components.showLabelAfterEnteringText ? (text == "" ? "" : components.title) : components.title
        }
    }
    
    func paddingCalc() -> CGFloat {
        withAnimation(.easeOut(duration: 0.3)) {
            components.text.isEmpty ? 0 : 2
        }
    }
}

public extension View {
    func borderTFStyle(components: BorderTFStyleComponents) -> some View {
        modifier(BorderTFStyle(components: components))
    }
}

public extension View {
    func underlineTextField(color: Color) -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(color)
            .padding(10)
    }
}
