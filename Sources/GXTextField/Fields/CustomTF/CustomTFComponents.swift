//
//  CustomTFComponents.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

public struct CustomTFComponents: CustomTFProtocol {
    var inputType: CustomTFType

    var textColor: Color
    @Binding var isEditing: Bool
    var placeholder: String
    var width: CGFloat
    var height: CGFloat
    var keyboardType: UIKeyboardType
    var isShowSecureField: Bool
    var onlyNumbers: Bool
    var validSymbolsAmount: Int?
    var textFormat: CustomTFFormat?
    var alwaysShowFractions: Bool
    
    var commit: () -> Void
    var onTap: () -> Void
    var onChangeOfText: (String) -> Void
    var onChangeOfIsEditing: (Bool) -> Void
    var hideKeyboard: () -> Void
}
