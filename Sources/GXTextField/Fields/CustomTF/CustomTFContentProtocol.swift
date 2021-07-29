//
//  CustomTFContentProtocol.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

public protocol CustomTFContentProtocol {
    associatedtype LeadingContent: View
    associatedtype TrailingContent: View

    var width: CGFloat? { get set }
    var height: CGFloat? { get set }
    var isShowLeadingContent: Bool { get set }
    var isShowTrailingContent: Bool { get set }
    var leadingContent: () -> LeadingContent? { get set }
    var trailingContent: () -> TrailingContent? { get set }
}
