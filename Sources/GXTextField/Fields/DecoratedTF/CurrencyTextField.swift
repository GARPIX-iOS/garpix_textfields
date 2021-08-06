//
//  CurrencyTextField.swift
//  
//
//  Created by Anton Vlezko on 28.07.2021.
//

import SwiftUI

/// Это текстовое поле используется для ввода цен и т. Д. Вы можете изменить валюту как строку и управлять другими значениями, чтобы получить дополнительные сведения, проверьте файл TextFieldSample
///
/// Стандартная  версия
/// ```
/// @State private var dollarPrice: Int? = nil
///
/// var body: some View {
///     // создаем bindingTotalInput который конвертирует Int? в формат Double? которую может принимать наш TF
///
///     let bindingTotalInput = Binding<Double?>(
///         get: { self.dollarPrice.optIntToOptDouble() },
///         set: { self.dollarPrice = $0.optDoubleToOptInt() }
///     )
///
///     CurrencyTextField(
///         totalInput: bindingTotalInput,
///         currencySymbol: "$"
///     ) // output -> стандартный TF с минимумом значений
/// }
/// ```
/// Расширенная версия
/// ```
/// @State private var dollarPrice: Double? = nil
/// @State private var dollarPriceBorderStyle: BorderStyles = BorderStyles.standart
/// @State private var dollarPriceIsEditing: Bool = false
///
/// var body: some View {
///     CurrencyTextField(
///         totalInput: dollarPrice,
///         currencySymbol: "$",
///         textColor: .red,
///         isEditing: dollarPriceIsEditing,
///         placeholder: placeholder,
///         width: UIScreen.main.bounds.width * 0.9,
///         height: 60,
///         alwaysShowFractions: false,
///         onTap: {
///             // вводим методы которые должны сработать после нажатия на TF
///         },
///         onChangeOfIsEditing: { value in
///             dollarPriceBorderStyle = value ? .selected : .standart
///             // вводим методы которые должны сработать после изменения dollarPriceIsEditing к примеру изменения dollarPriceBorderStyle для передачи его в модификатор стиля
///         },
///         hideKeyboard: {
///             dollarPriceIsEditing = false
///             // вводим методы которые должны сработать после того как будет скрыта клавиатура TF
///         }
///     ) // output -> стандартный TF с минимумом значений
/// }
/// ```
public struct CurrencyTextField: View, CustomTFProtocol {
    // MARK: - Properties
    
    /// Это значение помогает CustomERS распознать, какой тип ввода вы хотите передать
    var inputType: CustomTFType
    
    var textColor: Color
    @Binding var isEditing: Bool
    var placeholder: String
    var width: CGFloat
    var height: CGFloat
    var keyboardType: UIKeyboardType
    var isShowSecureField: Bool
    
    /// Эта переменная всегда будет показывать дроби в NumbersTextField
    var alwaysShowFractions: Bool
    
    var formatType: CustomTFFormatType?
    var onTap: () -> Void
    var onChangeOfIsEditing: (Bool) -> Void
    var commit: () -> Void
    var hideKeyboard: () -> Void
    
    
    // MARK: - Init
    public init(
        totalInput: Binding<Double?>,
        currencySymbol: String?,
        textColor: Color = .primary,
        isEditing: Binding<Bool> = .constant(false),
        placeholder: String = "",
        width: CGFloat = UIScreen.main.bounds.width * 0.9,
        height: CGFloat = 60,
        alwaysShowFractions: Bool = false,

        onTap: @escaping () -> Void = {},
        onChangeOfIsEditing: @escaping (Bool) -> Void = {_ in},
        hideKeyboard: @escaping () -> Void = {}
    ) {
        self.inputType = .decimal(totalInput: totalInput,
                                  currencySymbol: currencySymbol)

        self.textColor = textColor
        _isEditing = isEditing
        self.placeholder = placeholder
        self.width = width
        self.height = height
        self.keyboardType = .numberPad
        self.isShowSecureField = false
        self.alwaysShowFractions = alwaysShowFractions

        self.commit = {}
        self.onTap = onTap
        self.formatType = nil
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
            width: width,
            height: height,
            keyboardType: keyboardType,
            isShowSecureField: isShowSecureField,
            alwaysShowFractions: alwaysShowFractions,
            formatType: formatType,
            commit: commit,
            onTap: onTap,
            onChangeOfIsEditing: onChangeOfIsEditing,
            hideKeyboard: hideKeyboard)
        
        CustomTF(components: components)
            .frame(minWidth: 0, maxWidth: width, minHeight: 0, maxHeight: height, alignment: .center)
    }
}
