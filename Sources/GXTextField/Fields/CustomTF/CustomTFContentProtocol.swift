//
//  CustomTFContentProtocol.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

// MARK:- Protocol

/// This protocol provides variables will help of witch you can add content at leading or trailing by horizontal axis on both sides of textfield
public protocol CustomTFContentProtocol {
    associatedtype LeadingContent: View
    associatedtype TrailingContent: View

    var width: CGFloat? { get set }
    var height: CGFloat? { get set }
    
    /// Use those variables to hide of show content
    var isShowLeadingContent: Bool { get set }
    var isShowTrailingContent: Bool { get set }
    
    var leadingContent: () -> LeadingContent? { get set }
    var trailingContent: () -> TrailingContent? { get set }
}
