//
//  View + Extension.swift
//  Red
//
//  Created by Danil Lomaev on 04.03.2021.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
    extension View {
        func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }

    extension View {
        func changeAlertControllerColor(tintColor: Color) {
            // hack for change color in action sheet
            UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(tintColor)
        }
    }
#endif
