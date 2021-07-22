//
//  BorderTFStyleProtocol.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

public enum BorderStyles {
    case standart
    case selected
    case error
}

protocol BorderTFStyleProtocol {
    var borderStyle: BorderStyles { get set }
    var showLabel: Bool { get set }
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
}

// MARK: - Helper Functions
extension BorderTFStyleProtocol {
    func strokeColorCalculator() -> Color {
        switch borderStyle {
        case .standart: return strokeStandartColor
        case .selected: return strokeSelectedColor
        case .error: return strokeErrorColor
        }
    }
}
