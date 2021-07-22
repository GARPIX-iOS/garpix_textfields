//
//  ClearTextButton.swift
//  Red
//
//  Created by Danil Lomaev on 30.03.2021.
//

import SwiftUI

public struct ClearTextButton: View {
    @Binding var clearingText: String
    
    public init(clearingText: Binding<String>) {
        _clearingText = clearingText
    }
    
    public var body: some View {
        Button(action: {
            clearingText = ""
        }) {
            Image(systemName: "xmark")
                .renderingMode(.template)
                .foregroundColor(.black)
                .frame(width: 15, height: 15, alignment: .center)
        }
    }
}

struct ClearTextButton_Previews: PreviewProvider {
    static var previews: some View {
        ClearTextButton(clearingText: .constant("Hello!"))
    }
}
