//
//  CustomTFVerticalContent.swift
//  
//
//  Created by Anton Vlezko on 24.09.2021.
//

import SwiftUI

// MARK:- Struct

/// Этот ViewModifier реализует переменные и методы CustomTFVerticalContentProtocol необходимые для добавления View с разных сторон текстфилда
public struct CustomTFVerticalContent<TopContent: View, BottomContent: View>: ViewModifier, CustomTFVerticalContentProtocol {
    @Binding public var isShowTopContent: Bool
    @Binding public var isShowBottomContent: Bool
    public var topContent: () -> TopContent?
    public var bottomContent: () -> BottomContent?
    
    public func body(content: Content) -> some View {
        VStack(spacing: 0, alignment: .leading) {
            topButtonsView
            content
            bottomButtonsView
        }
    }
    
    @ViewBuilder
    var topButtonsView: some View {
        if isShowTopContent {
            topContent()
        }
    }
    
    @ViewBuilder
    var bottomButtonsView: some View {
        if isShowBottomContent {
            bottomContent()
        }
    }
}

// MARK:- View extension for customTFContent

public extension View {
    /// Используйте эту функцию для добавления содержимого с обеих сторон TF
    /// ```
    /// StandartTextField(text: $text)
    ///     .customTFVerticalContent(
    ///         // Вы можете передать сюда binding и по своему условию скрывать или показывать контент
    ///         isShowTopContent: .constant(true),
    ///         isShowBottomContent: .constant(true),
    ///
    ///         // Вы можете передать сюда View различных типов
    ///         topContent: {
    ///             Text("Text") // View
    ///         },
    ///         bottomContent: {
    ///             ClearTextButton(clearingText: $text)
    ///         }
    ///     )
    /// ```
    func customTFVerticalContent<TopContent: View, BottomContent: View>(
        isShowTopContent: Binding<Bool>,
        isShowBottomContent: Binding<Bool>,
        topContent: @escaping () -> TopContent?,
        bottomContent: @escaping () -> BottomContent?
    ) -> some View  {
        
        modifier(
            CustomTFVerticalContent(
                isShowTopContent: isShowTopContent,
                isShowBottomContent: isShowBottomContent,
                topContent: topContent,
                bottomContent: bottomContent
            )
        )
    }
    
    /// Используйте эту функцию для добавления содержимого сверху TF
    /// ```
    /// StandartTextField(text: $text)
    ///     .customTFVerticalContent(
    ///         // Вы можете передать сюда binding и по своему условию скрывать или показывать контент
    ///         isShowTopContent: .constant(true),
    ///
    ///         // Вы можете передать сюда View различных типов
    ///         topContent: {
    ///             Text("Text") // View
    ///         }
    ///     )
    /// ```
    func customTFVerticalContent<TopContent: View>(
        isShowTopContent: Binding<Bool>,
        topContent: @escaping () -> TopContent?
    ) -> some View  {
        
        modifier(
            CustomTFVerticalContent(
                isShowTopContent: isShowTopContent,
                isShowBottomContent: .constant(false),
                topContent: topContent,
                bottomContent: {
                    EmptyView()
                }
            )
        )
    }
    
    /// Используйте эту функцию, чтобы добавить контент снизу TF
    /// ```
    /// StandartTextField(text: $text)
    ///     .customTFVerticalContent(
    ///         // Вы можете передать сюда binding и по своему условию скрывать или показывать контент
    ///         isShowBottomContent: .constant(true),
    ///
    ///         // Вы можете передать сюда View различных типов
    ///         bottomContent: {
    ///             ClearTextButton(clearingText: $text)
    ///         }
    ///     )
    /// ```
    func customTFVerticalContent<BottomContent: View>(
        isShowBottomContent: Binding<Bool>,
        bottomContent: @escaping () -> BottomContent?
    ) -> some View {
        
        modifier(
            CustomTFVerticalContent(
                isShowTopContent: .constant(false),
                isShowBottomContent: isShowBottomContent,
                topContent: {
                    EmptyView()
                },
                bottomContent: bottomContent
            )
        )
    }
}
