//
//  BorderTFStyle.swift
//  
//
//  Created by Anton Vlezko on 20.07.2021.
//

import Foundation
import SwiftUI

// MARK: - Struct

/// This View takes as variable BorderTFStyleComponents and provide adding new style to TF according components data
public struct BorderTFStyle: ViewModifier {
    var components: BorderTFStyleComponents
    
    
    /// This function apply changes to TF with passed components
    /// - Parameter content: TF
    /// - Returns: TF with new View
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
                                    Text(components.title)
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
    /// It is service helper function fix the bug when in standart style stroke has small point of padding with background color
    /// - Returns: fixed padding
    func paddingCalc() -> CGFloat {
        withAnimation(.easeOut(duration: 0.3)) {
            components.showLabel ? 2 : 0
        }
    }
}
