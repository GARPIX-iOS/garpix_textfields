//
//  BorderTFStyle.swift
//  
//
//  Created by Anton Vlezko on 20.07.2021.
//

import Foundation
import SwiftUI

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
