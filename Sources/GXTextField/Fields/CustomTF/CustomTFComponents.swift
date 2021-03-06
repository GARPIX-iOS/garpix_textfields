//
//  CustomTFComponents.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

// MARK:- Struct

/// Эта структура используется для уменьшения объема кода, при init CustomTF
public struct CustomTFComponents: CustomTFProtocol {
    
    var inputType: CustomTFType

    var textColor: Color
    @Binding var isEditing: Bool
    var placeholder: String
    var placeholderColor: Color?
    var placeholderFont: Font = .callout
    var keyboardType: UIKeyboardType
    var isShowSecureField: Bool
    var alwaysShowFractions: Bool
    var font: Font = .callout
    var uiFont: UIFont? = nil
    
    var formatType: CustomTFFormatType?
    var commit: () -> Void
    var onTap: () -> Void
    var onChangeOfIsEditing: (Bool) -> Void
    var hideKeyboard: () -> Void
    
    var isShowToolbar: Bool = false
    var toolBarViewCallback: ((UITextField) -> Void)?
}
