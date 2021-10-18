//
//  StandartTextField.swift
//  
//
//  Created by Anton Vlezko on 28.07.2021.
//

import SwiftUI

// MARK: - View

/// Это текстовое поле используется для ввода строковых значений. Вы можете легко использовать маску в завершении onChangeOfText или использовать наши значения в textFormat, более того, если вы добавите validSymbolsAmount, вы получите поле с таким количеством символов для дополнительной проверки файла TextFieldSample
///
/// Стандартная  версия
/// ```
/// @State private var text: String = ""
///
/// var body: some View {
///     StandartTextField(
///         text: $text
///     ) // output -> стандартный TF с минимум значений
/// }
/// ```
/// Расширенная версия
/// ```
/// @State private var text: String = ""
/// @State private var textBorderStyle: BorderStyles = BorderStyles.standart
/// @State private var textIsEditing: Bool = false
///
/// var body: some View {
///     StandartTextField(
///         text: $text,
///         textColor: .blue,
///         isEditing: $textIsEditing,
///         placeholder: placeholder,
///         width: UIScreen.main.bounds.width * 0.9,
///         height: 60,
///         keyboardType: .decimalPad,
///         isShowSecureField: false,
/// ```
///  Реализация formatType через onChangeOfText для того, чтобы получить доступ напрямую к тексту и его изменениям
/// ```
///         formatType: .init(
///             onChangeOfText: { value in
///                 text = value.formatText(...)
///             }
///         ),
/// ```
///  Реализация formatType через textFormat так вы можете выбрать из предложенных нами вариантов форматирования
/// ```
///         formatType: .init(textFormat: .formatPhone),
/// ```
///  Реализация formatType через validSymbolsAmount так вы можете ограничить число вводимых пользователем символов
/// ```
///         formatType: .init(validSymbolsAmount: 10),
/// ```
///  Реализация formatType через validSymbolsAmount, а также inputType так вы можете ограничить число вводимых пользователем символов, а также внести ограничения для вводимых исволов например выбрать определенный язык, содержание только текста и тд
/// ```
///         formatType: .init(
///             validSymbolsAmount: 10,
///             inputType: .init(
///                 formatLanguage: .rus,
///                 containsText: true,
///                 containsNumbers: false,
///                 containsSpecialSymbols: true
///             )
///         ),
///         commit: {
///             // вводим методы которые должны сработать после commit в TF
///         },
///         onTap: {
///             // вводим методы которые должны сработать после нажатия на TF
///         },
///         onChangeOfIsEditing: { value in
///             textBorderStyle = value ? .selected : .standart
///             // вводим методы которые должны сработать после изменения textIsEditing к примеру изменения textBorderStyle для передачи его в модификатор стиля
///         },
///         hideKeyboard: {
///             textIsEditing = false
///             // вводим методы которые должны сработать после того как будет скрыта клавиатура TF
///         }
///     )
/// }
/// ```
public struct StandartTextField: View, CustomTFProtocol {
    // MARK: - Properties
    
    /// Это значение помогает CustomERS распознать, какой тип ввода вы хотите передать
    var inputType: CustomTFType
    
    var textColor: Color
    var backgroundColor: Color
    var placeholderColor: Color?
    var placeholderFont: Font = .callout
    @Binding var isEditing: Bool
    var placeholder: String
    var keyboardType: UIKeyboardType
    
    /// Эта переменная используется только для стандартного текстового поля, если вы хотите защитить это поле от пароля
    var isShowSecureField: Bool
    
    var alwaysShowFractions: Bool
    
    var formatType: CustomTFFormatType?
    var onTap: () -> Void
    var onChangeOfIsEditing: (Bool) -> Void
    var commit: () -> Void
    var hideKeyboard: () -> Void
    
    // MARK: - Init
    public init(
        text: Binding<String>,
        textColor: Color = .primary,
        placeholderColor: Color = .primary,
        isEditing: Binding<Bool> = .constant(false),
        placeholder: String = "",
        placeholderFont: Font = .callout,
        keyboardType: UIKeyboardType = .default,
        isShowSecureField: Bool = false,
        formatType: CustomTFFormatType? = nil,
        commit: @escaping () -> Void = {},
        onTap: @escaping () -> Void = {},
        onChangeOfIsEditing: @escaping (Bool) -> Void = {_ in},
        hideKeyboard: @escaping () -> Void = {}
    ) {
        self.inputType = .standart(text: text)
        
        self.textColor = textColor
        self.placeholderColor = placeholderColor
        self.placeholderFont = placeholderFont
        _isEditing = isEditing
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.isShowSecureField = isShowSecureField
        self.alwaysShowFractions = false
        
        self.formatType = formatType
        self.commit = commit
        self.onTap = onTap
        self.onChangeOfIsEditing = onChangeOfIsEditing
        self.hideKeyboard = hideKeyboard
    }
    
    // MARK: - View
    public var body: some View {
        let components = CustomTFComponents(
            inputType: inputType,
            textColor: textColor,
            isEditing: $isEditing,
            placeholder: placeholder,
            placeholderColor: placeholderColor,
            placeholderFont: placeholderFont,
            keyboardType: keyboardType,
            isShowSecureField: isShowSecureField,
            alwaysShowFractions: alwaysShowFractions,
            formatType: formatType,
            commit: commit,
            onTap: onTap,
            onChangeOfIsEditing: onChangeOfIsEditing,
            hideKeyboard: hideKeyboard)
        
        CustomTF(components: components)
    }
}
