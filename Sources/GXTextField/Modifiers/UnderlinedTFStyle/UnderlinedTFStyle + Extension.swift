//
//  UnderlinedTFStyle + Extension.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

// MARK: - View extension for underlinedTFStyle
public extension View {
    /// Этот метод необходим для применения изменений стиля к TF.
    /// ```
    /// StandartTextField(text: $text)
    ///     .underlinedTFStyle(color: .red) // output -> View с примененным на нем стилем
    /// ```
    /// - Parameter color: передайте сюда свой собственный цвет
    /// - Returns: View с примененным стилем
    func underlinedTFStyle(color: Color) -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle()
                        .frame(height: 2)
                        .padding(.top, 35)
                        .foregroundColor(color))
            .padding(10)
    }
}
