//
//  Date + extension.swift
//  
//
//  Created by Anton Vlezko on 28.07.2021.
//

import Foundation

public extension Date {
    func dateToString(dateFormat: DateFormats) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue
        return formatter.string(from: self)
    }
}

public extension DateFormatter {
    static var dd_MMMM_yyyy: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormats.dayMonthLetterYear.rawValue
        return formatter
    }

    static var ddMMyyyy: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormats.dayMonthDigitsYear.rawValue
        return formatter
    }
    
    static var yyyyMMdd: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormats.yearMonthDayWithDots.rawValue
        return formatter
    }
    
    static var yyyyMMddLine: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormats.yearMonthDayWithLine.rawValue
        return formatter
    }
    
    static var serverTime: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormats.serverTime.rawValue
        return formatter
    }
    
    static var dd_MMM_yyyy_In_HHmm: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormats.dayMonthLetterYearAndTime.rawValue
        return formatter
    }
    
    static var HHmm: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormats.timeWithDigits.rawValue
        return formatter
    }
    
    static var yyyyMMddHHmmss: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormats.yearMonthDayWithLineAndTime.rawValue
        return formatter
    }
}
