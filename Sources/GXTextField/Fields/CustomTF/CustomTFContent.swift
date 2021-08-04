//
//  CustomTFContent.swift
//  
//
//  Created by Anton Vlezko on 29.07.2021.
//

import SwiftUI

// MARK:- Struct

/// Эти ViewModifier предоставляют функциональные возможности для добавления к отдельным представлениям из CustomTFContentProtocol
public struct CustomTFContent<LeadingContent: View, TrailingContent: View>: ViewModifier, CustomTFContentProtocol {
    public var width: CGFloat?
    public var height: CGFloat?
    @Binding public var isShowLeadingContent: Bool
    @Binding public var isShowTrailingContent: Bool
    public var leadingContent: () -> LeadingContent?
    public var trailingContent: () -> TrailingContent?
    
    public func body(content: Content) -> some View {
        HStack(spacing: 10) {
            leadingButtonsView
            content
            trailingButtonsView
        }
        .frame(width: width ?? .infinity, height: height ?? 60, alignment: .center)
    }
    
    @ViewBuilder
    var leadingButtonsView: some View {
        if isShowLeadingContent {
            leadingContent()
                .padding(.leading, 16)
        }
    }
    
    @ViewBuilder
    var trailingButtonsView: some View {
        if isShowTrailingContent {
            trailingContent()
                .padding(.trailing, 16)
        }
    }
}

// MARK:- View extension for customTFContent

public extension View {
    /// Используйте эту функцию для добавления содержимого с обеих сторон textField
    func customTFContent<LeadingContent: View, TrailingContent: View>(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        isShowLeadingContent: Binding<Bool>,
        isShowTrailingContent: Binding<Bool>,
        leadingContent: @escaping () -> LeadingContent?,
        trailingContent: @escaping () -> TrailingContent?
    ) -> some View  {
        
        modifier(
            CustomTFContent(
                width: width,
                height: height,
                isShowLeadingContent: isShowLeadingContent,
                isShowTrailingContent: isShowTrailingContent,
                leadingContent: leadingContent,
                trailingContent: trailingContent
            )
        )
    }

    /// Используйте эту функцию для добавления содержимого в начало текстового поля
    func customTFContent<LeadingContent: View>(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        isShowLeadingContent: Binding<Bool>,
        leadingContent: @escaping () -> LeadingContent?
    ) -> some View  {
        
        modifier(
            CustomTFContent(
                width: width,
                height: height,
                isShowLeadingContent: isShowLeadingContent,
                isShowTrailingContent: .constant(false),
                leadingContent: leadingContent,
                trailingContent: {
                    EmptyView()
                }
            )
        )
    }
    
    /// Используйте эту функцию, чтобы добавить контент в конце textField
    func customTFContent<TrailingContent: View>(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        isShowTrailingContent: Binding<Bool>,
        trailingContent: @escaping () -> TrailingContent?
    ) -> some View {
        
        modifier(
            CustomTFContent(
                width: width,
                height: height,
                isShowLeadingContent: .constant(false),
                isShowTrailingContent: isShowTrailingContent,
                leadingContent: {
                    EmptyView()
                },
                trailingContent: trailingContent
            )
        )
    }
}
