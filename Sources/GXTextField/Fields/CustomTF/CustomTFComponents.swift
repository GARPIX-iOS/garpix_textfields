//
//  CustomTFComponents.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

// MARK:- Struct

/// This struct is used to decrease amount of code when CustomTF is init
public struct CustomTFComponents: CustomTFProtocol {
    var inputType: CustomTFType

    var textColor: Color
    @Binding var isEditing: Bool
    var placeholder: String
    var width: CGFloat
    var height: CGFloat
    var keyboardType: UIKeyboardType
    var isShowSecureField: Bool
    var alwaysShowFractions: Bool
    
    var formatType: CustomTFFormatType?
    var commit: () -> Void
    var onTap: () -> Void
    var onChangeOfIsEditing: (Bool) -> Void
    var hideKeyboard: () -> Void
}
