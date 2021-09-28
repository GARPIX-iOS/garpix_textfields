//
//  UnderlinedTFStyle + Extension.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

// MARK: - View extension for underlinedTFStyle
public struct UnderlinedTFStyle: ViewModifier {
    public var color: Color
    public var height: CGFloat
    public var spacing: CGFloat
    public var paddingLeading: CGFloat

    public func body(content: Content) -> some View {
        VStack(spacing: spacing) {
            content
            Rectangle()
                .frame(height: height)
                .foregroundColor(color)
                .padding(.leading, paddingLeading)
        }
    }
}

public extension View {
    /// Этот метод необходим для применения изменений стиля к TF.
    /// ```
    /// StandartTextField(text: $text)
    ///     .underlinedTFStyle(color: .red) // output -> View с примененным на нем стилем
    /// ```
    /// - Parameter color: передайте сюда свой собственный цвет
    /// - Returns: View с примененным стилем
    func underlinedTFStyle(
        color: Color,
        height: CGFloat? = nil,
        spacing: CGFloat? = nil,
        paddingLeading: CGFloat? = nil
    ) -> some View {
        modifier(
            UnderlinedTFStyle(
                color: color,
                height: height ?? 2,
                spacing: spacing ?? 0,
                paddingLeading: paddingLeading ?? 12
            )
        )
    }
    
    func underlinedTFStyleOverlaying(
        color: Color,
        height: CGFloat? = 2,
        paddingTop: CGFloat? = 35
    ) -> some View {
        self
            .overlay(Rectangle()
                        .frame(height: height)
                        .padding(.top, paddingTop)
                        .foregroundColor(color))
    }
}
