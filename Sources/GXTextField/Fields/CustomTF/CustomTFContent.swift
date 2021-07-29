//
//  CustomTFContent.swift
//  
//
//  Created by Anton Vlezko on 29.07.2021.
//

import SwiftUI

public struct CustomTFContent<LeadingContent: View, TrailingContent: View>: ViewModifier, CustomTFContentProtocol {
    public var width: CGFloat?
    public var height: CGFloat?
    public var isShowLeadingContent: Bool
    public var isShowTrailingContent: Bool
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

public extension View {
    func customTFContent<LeadingContent: View, TrailingContent: View>(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        isShowLeadingContent: Bool,
        isShowTrailingContent: Bool,
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
    
    func customTFContent<LeadingContent: View>(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        isShowLeadingContent: Bool,
        leadingContent: @escaping () -> LeadingContent?
    ) -> some View  {
        
        modifier(
            CustomTFContent(
                width: width,
                height: height,
                isShowLeadingContent: isShowLeadingContent,
                isShowTrailingContent: false,
                leadingContent: leadingContent,
                trailingContent: {
                    EmptyView()
                }
            )
        )
    }
    
    func customTFContent<TrailingContent: View>(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        isShowTrailingContent: Bool,
        trailingContent: @escaping () -> TrailingContent?
    ) -> some View {
        
        modifier(
            CustomTFContent(
                width: width,
                height: height,
                isShowLeadingContent: false,
                isShowTrailingContent: isShowTrailingContent,
                leadingContent: {
                    EmptyView()
                },
                trailingContent: trailingContent
            )
        )
    }
}
