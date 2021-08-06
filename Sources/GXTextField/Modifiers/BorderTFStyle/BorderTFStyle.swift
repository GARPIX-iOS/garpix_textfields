//
//  BorderTFStyle.swift
//  
//
//  Created by Anton Vlezko on 20.07.2021.
//

import Foundation
import SwiftUI

// MARK: - ViewModifier

/// Этот ViewModifier принимает в качестве переменной BorderTFStyleComponents и обеспечивает добавление нового стиля в TF в соответствии с данными компонентов
public struct BorderTFStyle: ViewModifier {
    var components: BorderTFStyleComponents
    /// Эта функция применяет изменения к TF с переданными компонентами
    /// - Parameter content: TF
    /// - Returns: TF с новым стилем
    public func body(content: Content) -> some View {
        content
            .overlay(
                ZStack(alignment: .topLeading) {
                    Group {
                        RoundedRectangle(cornerRadius: components.cornerRadius)
                            .stroke(components.strokeColorCalculator(),
                                    lineWidth: components.strokeWidth)
                            HStack {
                                if components.showLabel {
                                    Text(components.text)
                                        .font(components.font)
                                    if !components.image.isEmpty {
                                        Image(systemName: components.image)
                                    }
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

// MARK: - BorderTFStyle Helper Functions
extension BorderTFStyle {
    /// Это служебная вспомогательная функция, исправляющая ошибку, когда в стандартном стиле у бордера отображается точка цветом бэкграунда
    /// - Returns: исправленная величина padding 
    func paddingCalc() -> CGFloat {
        withAnimation(.easeOut(duration: 0.3)) {
            components.showLabel ? 2 : 0
        }
    }
}
