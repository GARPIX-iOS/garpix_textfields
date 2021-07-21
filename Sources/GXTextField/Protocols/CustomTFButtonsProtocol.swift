//
//  CustomTFButtonsProtocol.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

protocol CustomTFButtonsProtocol {
    associatedtype LeadingContent: View
    associatedtype TrailingContent: View
    
    var leadingContent: () -> LeadingContent? { get set }
    var trailingContent: () -> TrailingContent? { get set }
}
