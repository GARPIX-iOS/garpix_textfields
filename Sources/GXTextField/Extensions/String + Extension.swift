//
//  String + Extension.swift
//  Red
//
//  Created by Danil Lomaev on 17.03.2021.
//

import Foundation
import UIKit

// MARK: - Format Mask

extension String {
    func formatGosnumber(with mask: String = "X 111 XX 111",
                         letterSymbol: String.Element = "X",
                         numberSymbol: String.Element = "1") -> String {
        var result = ""
        let value = replacingOccurrences(of: " ", with: "")
        var index = value.startIndex

        for ch in mask where index < value.endIndex {
            if ch == letterSymbol {
                result.append(String(value[index]).replacingOccurrences(of: "[^АВЕКМНОРСТУХABEKMHOPCTYX]", with: "", options: .regularExpression))
                index = value.index(after: index)
            } else if ch == numberSymbol {
                result.append(String(value[index]).replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression))
                index = value.index(after: index)
            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }

    func formatPhone(with mask: String = "+Y (XXX) XXX-XX-XX") -> String {
        let numbers = replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "Y" {
                // mask requires a number in this place, so take the next one
                result.append("7")
                // move numbers iterator to the next index
                index = numbers.index(after: index)
            } else if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }

    var clearPhoneNumber: String {
        return "+" + filter { $0.isNumber }
    }

    func formatText(with mask: String, symbol: String.Element, onlyNumbers: Bool) -> String {
        var result = ""
        var value = self
        let numbersReplacing = "[^0-9]"
        let textReplacing = "[^A-Za-zА-яа-я0-9]"

        // value iterator
        var index = value.startIndex

        if onlyNumbers {
            value = replacingOccurrences(of: numbersReplacing, with: "", options: .regularExpression)
        } else {
            value = replacingOccurrences(of: textReplacing, with: "", options: .regularExpression)
        }

        // iterate over the mask characters until the iterator of values ends
        for ch in mask where index < value.endIndex {
            if ch == symbol {
                // mask requires a value in this place, so take the next one
                result.append(value[index])

                // move values iterator to the next index
                index = value.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
}

// MARK: - Validation

extension String {
    // MARK: - isValidEmail

    var isValidEmail: Bool {
        guard !isEmpty else {
            return false
        }

        let entireRange = NSRange(location: 0, length: count)

        let types: NSTextCheckingResult.CheckingType = [.link]

        guard let detector = try? NSDataDetector(types: types.rawValue) else {
            return false
        }

        let matches = detector.matches(in: self, options: [], range: entireRange)

        // should only have a single match
        guard matches.count == 1 else {
            return false
        }

        guard let result = matches.first else {
            return false
        }

        // result should be a link
        guard result.resultType == .link else {
            return false
        }

        // result should be a recognized mail address
        guard result.url?.scheme == "mailto" else {
            return false
        }

        // match must be entire string
        guard NSEqualRanges(result.range, entireRange) else {
            return false
        }

        // but schould not have the mail URL scheme
        if hasPrefix("mailto:") {
            return false
        }

        // no complaints, string is valid email address
        return true
    }
}

// MARK: - StringToDate extensions

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
