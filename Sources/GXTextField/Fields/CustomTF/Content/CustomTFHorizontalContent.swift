//
//  CustomTFHorizontalContent.swift
//  
//
//  Created by Anton Vlezko on 29.07.2021.
//

import SwiftUI

// MARK:- Struct

/// Этот ViewModifier реализует переменные и методы CustomTFHorizontalContentProtocol необходимые для добавления View с разных сторон текстфилда
public struct CustomTFHorizontalContent<LeadingContent: View, TrailingContent: View>: ViewModifier, CustomTFHorizontalContentProtocol {
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
    ///     .customTFHorizontalContent(
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
    func customTFHorizontalContent<LeadingContent: View, TrailingContent: View>(
        isShowLeadingContent: Binding<Bool>,
        isShowTrailingContent: Binding<Bool>,
        leadingContent: @escaping () -> LeadingContent?,
        trailingContent: @escaping () -> TrailingContent?
    ) -> some View  {
        
        modifier(
            CustomTFHorizontalContent(
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
    ///     .customTFHorizontalContent(
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
    func customTFHorizontalContent<LeadingContent: View>(
        isShowLeadingContent: Binding<Bool>,
        leadingContent: @escaping () -> LeadingContent?
    ) -> some View  {
        
        modifier(
            CustomTFHorizontalContent(
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
    ///     .customTFHorizontalContent(
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
    func customTFHorizontalContent<TrailingContent: View>(
        isShowTrailingContent: Binding<Bool>,
        trailingContent: @escaping () -> TrailingContent?
    ) -> some View {
        
        modifier(
            CustomTFHorizontalContent(
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
