//
//  Enums.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import Foundation

public enum DateFormats: String {
    case yearMonthDayWithDots = "yyyy.MM.dd"
    case yearMonthDayWithLine = "yyyy-MM-dd"
    case dayMonthLetterYear = "dd MMM yyyy"
    case dayMonthDigitsYear = "dd.MM.yyyy"
    case serverTime = "yyyy-MM-dd'T'HH:mm:ss+hh:mm"
    case dayMonthLetterYearAndTime = "dd MMM yyyy 'в' HH:mm"
    case timeWithDigits = "HH:mm"
    case yearMonthDayWithLineAndTime = "yyyy-MM-dd HH:mm:ss"
}
