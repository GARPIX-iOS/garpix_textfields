//
//  BorderTFStyleProtocol.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI
import UIKit

// MARK:- Enum

/// Это перечисление предоставляет три разных стиля для бордера
public enum BorderStyles {
    case standart
    case selected
    case error
}

// MARK:- Protocol

/// Этот протокол принимает все переменные, которые необходимы для применения стиля к TF
protocol BorderTFStyleProtocol {
    var borderStyle: BorderStyles { get set }
    
    /// Эта переменная помогает вам показать лейбл, при изменении какого-то параметра к примеру сюда можно передать $isEditing из TF
    var showLabel: Bool { get set }
    
    /// Текст бордера
    var text: String { get set }
    
    /// Вы можете передать сюда стандартное имя из SFSymbols, позже мы добавим функциональность для передачи View, как в TFContent
    var image: String { get set }
    var font: Font { get set }
    var textColor: Color { get set }
    var strokeWidth: CGFloat { get set }
    var strokeStandartColor: Color { get set }
    var strokeSelectedColor: Color { get set }
    var strokeErrorColor: Color { get set }
    var cornerRadius: CGFloat { get set }
    
    /// Смещение лейбла относительно ее изображения
    var offsetX: CGFloat { get set }
    var offsetY: CGFloat { get set }
    var backgroundColor: Color { get set }
}

// MARK: - BorderTFStyleProtocol Helper Functions
extension BorderTFStyleProtocol {
    /// Эта функция вычисляет цвет бордера в соответствии с текущим стилем
    /// - Returns: цвет бордера
    func strokeColorCalculator() -> Color {
        switch borderStyle {
        case .standart: return strokeStandartColor
        case .selected: return strokeSelectedColor
        case .error: return strokeErrorColor
        }
    }
}
