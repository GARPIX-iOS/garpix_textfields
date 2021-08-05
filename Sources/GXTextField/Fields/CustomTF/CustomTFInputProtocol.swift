//
//  CustomTFInputProtocol.swift
//  
//
//  Created by Anton Vlezko on 28.07.2021.
//

import SwiftUI
import GXUtilz

// MARK:- Enum

/// Это перечисление необходимо для передачи в CustomTF входных данных из DecoratedTF
enum CustomTFType {
    case standart(text: Binding<String>)
    case decimal(totalInput: Binding<Double?>, currencySymbol: String?)
    case date(date: Binding<Date?>, formatter: DateFormatter?)
}

// MARK:- Protocol

/// Этот протокол используется для добавления значений inputType в CustomTF
protocol CustomTFInputProtocol {
    var inputType: CustomTFType { get set }
}
