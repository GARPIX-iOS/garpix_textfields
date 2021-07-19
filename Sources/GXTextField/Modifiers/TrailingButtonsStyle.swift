//
//  TrailingButtonsStyle.swift
//  Red
//
//  Created by Danil Lomaev on 30.03.2021.
//

import Foundation
import SwiftUI

struct TrailingButtonsStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
//            .transition(.move(edge: .trailing))
            .animation(.default)
            .padding(.trailing, 10)
    }
}

extension View {
    func trailingButtonsStyle() -> some View {
        return modifier(TrailingButtonsStyle())
    }
}
