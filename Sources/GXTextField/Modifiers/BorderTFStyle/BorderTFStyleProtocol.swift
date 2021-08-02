//
//  BorderTFStyleProtocol.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI
import UIKit

// MARK:- Enum

/// This enum provides three different styles for border
public enum BorderStyles {
    case standart
    case selected
    case error
}

// MARK:- Protocol

/// This protocol takes all variables wich need to apply style to TF
protocol BorderTFStyleProtocol {
    var borderStyle: BorderStyles { get set }
    
    /// This variable helps you to show label you can pass here $isEditing from TF and looks how magic goes
    var showLabel: Bool { get set }
    
    /// Title of the label
    var title: String { get set }
    
    /// You can pass here standart name from SFSymbols later we will add functionality to pass View like in TFContent
    var image: String { get set }
    var font: Font { get set }
    var textColor: Color { get set }
    var strokeWidth: CGFloat { get set }
    var strokeStandartColor: Color { get set }
    var strokeSelectedColor: Color { get set }
    var strokeErrorColor: Color { get set }
    var cornerRadius: CGFloat { get set }
    
    /// Offset of Label with its Image
    var offsetX: CGFloat { get set }
    var offsetY: CGFloat { get set }
    var backgroundColor: Color { get set }
}

// MARK: - BorderTFStyleProtocol Helper Functions
extension BorderTFStyleProtocol {
    
    /// This function calculate stroke color according to current border style
    /// - Returns: color for the border
    func strokeColorCalculator() -> Color {
        switch borderStyle {
        case .standart: return strokeStandartColor
        case .selected: return strokeSelectedColor
        case .error: return strokeErrorColor
        }
    }
}
