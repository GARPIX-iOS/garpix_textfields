//
//  String + Extension.swift
//  Red
//
//  Created by Danil Lomaev on 17.03.2021.
//

import Foundation

public enum FormatWithLanguage {
    case rus
    case eng
}

// MARK: - Format Mask
extension String {
    /// This method will help to you to transform text as vehicle Gov Number
    /// - Parameters:
    ///   - mask: mask pls check symbols properly
    ///   - letterSymbol: letters of number
    ///   - numberSymbol: numbers of number
    ///   - formatLanguage: language of number
    /// - Returns: formatted string
    func formatGovNumber(with mask: String = "X 111 XX 111",
                         letterSymbol: String.Element = "X",
                         numberSymbol: String.Element = "1",
                         formatLanguage: FormatWithLanguage = .rus) -> String {
        var result = ""
        let value = replacingOccurrences(of: " ", with: "")
        var index = value.startIndex
        let numbersReplacing = "[^0-9]"
        var textReplacing = "[^А-Яа-я]"
        
        switch formatLanguage {
        case .rus:
            textReplacing = "[^А-Яа-я]"
        case .eng:
            textReplacing = "[^A-Za-z]"
        }
        
        for ch in mask where index < value.endIndex {
            if ch == letterSymbol {
                result.append(String(value[index]).replacingOccurrences(of: textReplacing, with: "", options: .regularExpression))
                index = value.index(after: index)
            } else if ch == numberSymbol {
                result.append(String(value[index]).replacingOccurrences(of: numbersReplacing, with: "", options: .regularExpression))
                index = value.index(after: index)
            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }

    
    /// This method will help to you to transform text to phone number later will be extended as GovNumber
    /// - Parameter mask: mask pls check symbols properly
    /// - Returns: formatted string
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
    
    /// This method will help to you to transform text with your own mask
    /// - Parameters:
    ///   - mask: mask pls check symbols properly
    ///   - symbol: symbols in mask and symbols here must be equal
    ///   - onlyNumbers: shows can user add text from .numpad or from chosen keyboard
    /// - Returns: formatted string
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

    /// Returns Bool value after checking is email valid
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
    
    /// That function transform String to Date
    /// - Parameter dateFormat: select case from provided values by enum
    /// - Returns: Returns Date from String
    func stringToDate(dateFormat: DateFormats = .yearMonthDayWithDots) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue
        return formatter.date(from: self)
    }
}
