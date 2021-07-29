//
//  CustomTFInputProtocol.swift
//  
//
//  Created by Anton Vlezko on 28.07.2021.
//

import SwiftUI

// MARK:- Enum

/// This enum tells the type of CustomTF helps to manage input data in DecoratedTF
enum CustomTFType {
    case standart(text: Binding<String>)
    case decimal(totalInput: Binding<Double?>, currencySymbol: String?)
    case date(date: Binding<Date?>, formatter: DateFormatter?)
}

// MARK:- Protocol

/// This protocol is used to add inputType values to CustomTF
protocol CustomTFInputProtocol {
    var inputType: CustomTFType { get set }
}
