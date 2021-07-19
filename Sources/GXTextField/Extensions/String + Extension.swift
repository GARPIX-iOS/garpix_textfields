//
//  String + Extension.swift
//  Red
//
//  Created by Danil Lomaev on 17.03.2021.
//

import Foundation
import UIKit

extension String {
    var validKbmValue: String {
        if let value = Double(self) {
            switch value {
            case ...0.5:
                return "0.5"
            case 2.45...:
                return "2.45"
            default:
                return String(format: "%.2f", value)
            }
        }
        return ""
    }
}

// MARK: - Format Mask

extension String {
    func formatGosnumber() -> String {
        let mask: String = "X 111 XX 111"
        var result = ""
        let value = replacingOccurrences(of: " ", with: "")
        var index = value.startIndex

        for ch in mask where index < value.endIndex {
            if ch == "X" {
                result.append(String(value[index]).replacingOccurrences(of: "[^АВЕКМНОРСТУХABEKMHOPCTYX]", with: "", options: .regularExpression))
                index = value.index(after: index)
            } else if ch == "1" {
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

    // MARK: - isValidCar

    var isValidGosNumber: Bool {
        return count == 11 || count == 12
    }
}

// MARK: - Helper Properties

extension String {
    var isStringContainsOnlyNumbers: Bool {
        return rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}

// MARK: - Helper Functions

extension String {
    func addComma() -> String {
        return self == "" ? "" : ", "
    }

    var words: [String] {
        return components(separatedBy: CharacterSet.alphanumerics.inverted).filter { !$0.isEmpty }
    }
}

// MARK: - getHeight and getWidth methods

extension String {
    func textSize(font: UIFont, text: String, width: CGFloat = .greatestFiniteMagnitude, height: CGFloat = .greatestFiniteMagnitude) -> CGSize {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        label.numberOfLines = 0
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.size
    }
}
