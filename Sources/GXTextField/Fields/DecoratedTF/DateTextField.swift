//
//  DateTextField.swift
//  
//
//  Created by Anton Vlezko on 28.07.2021.
//

import SwiftUI

/// Это текстовое поле используется для ввода даты с помощью настраиваемого средства выбора клавиатуры для дополнительной проверки файла TextFieldSample
///
/// Стандартная версия с минимумом кастомных значений, но использующая кастомный binding
/// ```
/// @State private var dateString: String? = nil
///
/// var body: some View {
///     // создаем bindingDate который конвертирует опциональную строку в формат опциональной даты которую может принимать наш TF
///
///     let timeDateFormat: DateFormats = .dayMonthDigitsYear
///     let bindingDate = Binding<Date?>(
///         get: { self.dateString?.stringToDate(dateFormat: timeDateFormat) },
///         set: { self.dateString = $0?.dateToString(dateFormat: timeDateFormat)
///     )
///
///     DateTextField(
///         date: bindingDate,
///         formatter: .ddMMyyyy,
///     ) // output -> стандартный TF с минимум значений
/// }
/// ```
/// Расширенная версия
/// ```
/// @State private var date: Date? = nil
/// @State private var dateBorderStyle: BorderStyles = BorderStyles.standart
/// @State private var dateIsEditing: Bool = false
///
/// var body: some View {
///     DateTextField(
///         date: date,
///         formatter: .ddMMyyyy,
///         textColor: .red,
///         isEditing: $dateIsEditing,
///         placeholder: placeholder,
///         width: UIScreen.main.bounds.width * 0.9,
///         height: 60,
///         onTap: {
///             // вводим методы которые должны сработать после нажатия на TF
///         },
///         onChangeOfIsEditing: { value in
///             dateBorderStyle = value ? .selected : .standart
///             // вводим методы которые должны сработать после изменения dateIsEditing к примеру изменения dateBorderStyle для передачи его в модификатор стиля
///         },
///         hideKeyboard: {
///             dateIsEditing = false
///             // вводим методы которые должны сработать после того как будет скрыта клавиатура TF
///         }
///     )
/// }
/// ```
public struct DateTextField: View, CustomTFProtocol {
    
    // MARK: - Properties
    
    /// Это значение помогает CustomERS распознать, какой тип ввода вы хотите передать
    var inputType: CustomTFType
    
    var textColor: Color
    var placeholderColor: Color?
    @Binding var isEditing: Bool
    var placeholder: String
    var keyboardType: UIKeyboardType
    var isShowSecureField: Bool
    var alwaysShowFractions: Bool
    
    var formatType: CustomTFFormatType?
    var onTap: () -> Void
    var onChangeOfIsEditing: (Bool) -> Void
    var commit: () -> Void
    var hideKeyboard: () -> Void
    
    // MARK: - Init
    public init(
        date: Binding<Date?>,
        formatter: DateFormatter? = nil,
        textColor: Color = .primary,
        placeholderColor: Color = .primary,
        isEditing: Binding<Bool> = .constant(false),
        placeholder: String = "",
        onTap: @escaping () -> Void = {},
        onChangeOfIsEditing: @escaping (Bool) -> Void = {_ in},
        hideKeyboard: @escaping () -> Void = {}
    )
    {
        self.inputType = .date(date: date,
                               formatter: formatter)
        
        self.textColor = textColor
        _isEditing = isEditing
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
        self.keyboardType = .default
        self.isShowSecureField = false
        self.alwaysShowFractions = false
        
        self.formatType = nil
        self.commit = {}
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
