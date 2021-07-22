//
//  Enums.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import Foundation

public extension String {
    func stringToDate(dateFormat: DateFormats = .yearMonthDayWithDots) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue
        return formatter.date(from: self)
    }

    func convertToDayMonthLetterYear() -> String? {
        let tempDate = stringToDate(dateFormat: .yearMonthDayWithLine)
        return tempDate?.dateToString(dateFormat: .dayMonthLetterYear)
    }

    func convertFromServerTime() -> String? {
        let tempTime = stringToDate(dateFormat: .serverTime)
        return tempTime?.dateToString(dateFormat: .yearMonthDayWithLine)
    }

    func convertToDayMonthDigitsYear() -> String? {
        let tempDate = stringToDate(dateFormat: .yearMonthDayWithLine)
        return tempDate?.dateToString(dateFormat: .dayMonthDigitsYear)
    }

    func convertFromServerTimeToUserTime() -> String? {
        let tempTime = stringToDate(dateFormat: .yearMonthDayWithLineAndTime)
        return tempTime?.dateToString(dateFormat: .dayMonthLetterYearAndTime)
    }

    func convertDateFormat(from: DateFormats, to: DateFormats) -> String? {
        let tempDate = stringToDate(dateFormat: from)
        return tempDate?.dateToString(dateFormat: to)
    }
}

public extension Date {
    func dateToString(dateFormat: DateFormats) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue
        return formatter.string(from: self)
    }

    func dateToStringTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}

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
}
