//
//  BorderTFStyleComponents.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

// MARK:- Struct

/// Эта структура используется для уменьшения объема кода, в BorderTF
public struct BorderTFStyleComponents: BorderTFStyleProtocol {
    @Binding var borderStyle: BorderStyles
    @Binding var showLabel: Bool
    var text: String
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
}
