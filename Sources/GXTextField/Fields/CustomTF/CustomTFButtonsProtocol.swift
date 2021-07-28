//
//  CustomTFButtonsProtocol.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

public protocol CustomTFButtonsProtocol {
    associatedtype LeadingContent: View
    associatedtype TrailingContent: View

    var isShowLeadingButtons: Bool { get set }
    var isShowTrailingButtons: Bool { get set }
    var leadingContent: () -> LeadingContent? { get set }
    var trailingContent: () -> TrailingContent? { get set }

//    init(
//        components: CustomTFComponents,
//        @ViewBuilder leadingContent: @escaping () -> LeadingContent?,
//        @ViewBuilder trailingContent: @escaping () -> TrailingContent?
//    )
}

//extension CustomTFButtonsProtocol {
//    init(components: CustomTFComponents) where LeadingContent == EmptyView, TrailingContent == EmptyView {
//        self.init(
//            components: components,
//            leadingContent: {
//                EmptyView()
//            },
//            trailingContent: {
//                EmptyView()
//            }
//        )
//    }
//
//    init(components: CustomTFComponents,
//         @ViewBuilder trailingContent: @escaping () -> TrailingContent?) where LeadingContent == EmptyView {
//        self.init(
//            components: components,
//            leadingContent: {
//                EmptyView()
//            },
//            trailingContent: trailingContent
//        )
//    }
//
//    init(components: CustomTFComponents,
//         @ViewBuilder leadingContent: @escaping () -> LeadingContent?) where TrailingContent == EmptyView {
//        self.init(
//            components: components,
//            leadingContent: leadingContent,
//            trailingContent: {
//                EmptyView()
//            }
//        )
//    }
//}
