//
//  UnderlinedTFStyle + Extension.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

// MARK: - View extension for underlinedTFStyle
public extension View {
    /// This method is needed to apply style changes to TF.
    /// - Parameter color: pass here your custom color
    /// - Returns: View with applied Style
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
