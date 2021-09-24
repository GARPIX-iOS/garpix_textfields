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
    public var width: CGFloat?
    public var height: CGFloat?
    @Binding public var isShowTopContent: Bool
    @Binding public var isShowBottomContent: Bool
    public var topContent: () -> TopContent?
    public var bottomContent: () -> BottomContent?
    
    
    public func body(content: Content) -> some View {
        VStack(spacing: 10) {
            topButtonsView
            content
            bottomButtonsView
        }
        .frame(width: width ?? .infinity, height: height ?? 60, alignment: .center)
    }
    
    @ViewBuilder
    var topButtonsView: some View {
        if isShowTopContent {
            topContent()
                .padding(.leading, 16)
        }
    }
    
    @ViewBuilder
    var bottomButtonsView: some View {
        if isShowBottomContent {
            bottomContent()
                .padding(.trailing, 16)
        }
    }
}

// MARK:- View extension for customTFContent

public extension View {
    /// Используйте эту функцию для добавления содержимого с обеих сторон TF
    /// ```
    /// StandartTextField(text: $text)
    ///     .customTFVerticalContent(
    ///         width: UIScreen.main.bounds.width * 0.9,
    ///
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
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        isShowTopContent: Binding<Bool>,
        isShowBottomContent: Binding<Bool>,
        topContent: @escaping () -> TopContent?,
        bottomContent: @escaping () -> BottomContent?
    ) -> some View  {
        
        modifier(
            CustomTFVerticalContent(
                width: width,
                height: height,
                isShowTopContent: isShowTopContent,
                isShowBottomContent: isShowBottomContent,
                topContent: topContent,
                bottomContent: bottomContent
            )
        )
    }
    
    /// Используйте эту функцию для добавления содержимого в начало TF
    /// ```
    /// StandartTextField(text: $text)
    ///     .customTFVerticalContent(
    ///         width: UIScreen.main.bounds.width * 0.9,
    ///
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
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        isShowTopContent: Binding<Bool>,
        topContent: @escaping () -> TopContent?
    ) -> some View  {
        
        modifier(
            CustomTFVerticalContent(
                width: width,
                height: height,
                isShowTopContent: isShowTopContent,
                isShowBottomContent: .constant(false),
                topContent: topContent,
                bottomContent: {
                    EmptyView()
                }
            )
        )
    }
    
    /// Используйте эту функцию, чтобы добавить контент в конце TF
    /// ```
    /// StandartTextField(text: $text)
    ///     .customTFVerticalContent(
    ///         width: UIScreen.main.bounds.width * 0.9,
    ///
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
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        isShowBottomContent: Binding<Bool>,
        bottomContent: @escaping () -> BottomContent?
    ) -> some View {
        
        modifier(
            CustomTFVerticalContent(
                width: width,
                height: height,
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
