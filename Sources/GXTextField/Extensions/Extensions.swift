//
//  Extensions.swift
//  Red
//
//  Created by Danil Lomaev on 05.04.2021.
//

import Foundation
import SwiftUI

public extension Optional where Wrapped == Int {
    func optIntToOptDouble() -> Double? {
        if let unwrapInt = self {
            return Double(unwrapInt)
        } else {
            return nil
        }
    }
}

public extension Optional where Wrapped == Double {
    func optDoubleToOptInt() -> Int? {
        if let unwrapDouble = self {
            return Int(unwrapDouble)
        } else {
            return nil
        }
    }
}
