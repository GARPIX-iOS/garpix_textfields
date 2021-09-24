//
//  CustomTFContentProtocol.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

// MARK:- Protocol

/// Этот протокол предоставляет переменные, которые помогут вам добавить  контент в начале или в конце по горизонтальной оси с обеих сторон текстового поля.
public protocol CustomTFHorizontalContentProtocol {
    associatedtype LeadingContent: View
    associatedtype TrailingContent: View

    var width: CGFloat? { get set }
    var height: CGFloat? { get set }
    
    /// Используйте эти переменные, чтобы скрыть отображение содержимого
    var isShowLeadingContent: Bool { get set }
    var isShowTrailingContent: Bool { get set }
    
    var leadingContent: () -> LeadingContent? { get set }
    var trailingContent: () -> TrailingContent? { get set }
}

/// Этот протокол предоставляет переменные, которые помогут вам добавить контент сверху или снизу по вертикальной оси с обеих сторон текстового поля.
public protocol CustomTFVerticalContentProtocol {
    associatedtype TopContent: View
    associatedtype BottomContent: View

    var width: CGFloat? { get set }
    var height: CGFloat? { get set }
    
    /// Используйте эти переменные, чтобы скрыть отображение содержимого
    var isShowTopContent: Bool { get set }
    var isShowBottomContent: Bool { get set }
    
    var topContent: () -> TopContent? { get set }
    var bottomContent: () -> BottomContent? { get set }
}
