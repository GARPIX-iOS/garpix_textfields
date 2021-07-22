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

// MARK: - Helper Functions
extension BorderTFStyle {
    func paddingCalc() -> CGFloat {
        withAnimation(.easeOut(duration: 0.3)) {
            components.showLabel ? 2 : 0
        }
    }
}
