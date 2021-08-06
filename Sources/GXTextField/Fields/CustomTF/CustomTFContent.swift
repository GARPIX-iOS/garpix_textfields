//
//  CustomTFContent.swift
//  
//
//  Created by Anton Vlezko on 29.07.2021.
//

import SwiftUI

// MARK:- Struct

/// Этот ViewModifier реализует переменные и методы CustomTFContentProtocol необходимые для добавления View с разных сторон текстфилда
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
    /// Используйте эту функцию для добавления содержимого с обеих сторон TF
    /// ```
    /// StandartTextField(text: $text)
    ///     .customTFContent(
    ///         width: UIScreen.main.bounds.width * 0.9,
    ///
    ///         // Вы можете передать сюда binding и по своему условию скрывать или показывать контент
    ///         isShowLeadingContent: .constant(true),
    ///         isShowTrailingContent: .constant(true),
    ///
    ///         // Вы можете передать сюда View различных типов
    ///         leadingContent: {
    ///             Text("Text") // View
    ///         },
    ///         trailingContent: {
    ///             ClearTextButton(clearingText: $text)
    ///         }
    ///     )
    /// ```
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

    /// Используйте эту функцию для добавления содержимого в начало TF
    /// ```
    /// StandartTextField(text: $text)
    ///     .customTFContent(
    ///         width: UIScreen.main.bounds.width * 0.9,
    ///
    ///         // Вы можете передать сюда binding и по своему условию скрывать или показывать контент
    ///         isShowLeadingContent: .constant(true),
    ///
    ///         // Вы можете передать сюда View различных типов
    ///         leadingContent: {
    ///             Text("Text") // View
    ///         }
    ///     )
    /// ```
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
    
    /// Используйте эту функцию, чтобы добавить контент в конце TF
    /// ```
    /// StandartTextField(text: $text)
    ///     .customTFContent(
    ///         width: UIScreen.main.bounds.width * 0.9,
    ///
    ///         // Вы можете передать сюда binding и по своему условию скрывать или показывать контент
    ///         isShowTrailingContent: .constant(true),
    ///
    ///         // Вы можете передать сюда View различных типов
    ///         trailingContent: {
    ///             ClearTextButton(clearingText: $text)
    ///         }
    ///     )
    /// ```
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
