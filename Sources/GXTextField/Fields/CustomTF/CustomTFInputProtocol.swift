//
//  CustomTFInputProtocol.swift
//  
//
//  Created by Anton Vlezko on 28.07.2021.
//

import SwiftUI

enum CustomTFType {
    case standart(text: Binding<String>)
    case decimal(totalInput: Binding<Double?>, currencySymbol: String?)
    case date(date: Binding<Date?>, formatter: DateFormatter?)
}

protocol CustomTFInputProtocol {
    var inputType: CustomTFType { get set }
}
