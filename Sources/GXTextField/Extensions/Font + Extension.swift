//
//  Font + Extension.swift
//  Red
//
//  Created by Danil Lomaev on 01.03.2021.
//

import Foundation
import SwiftUI

extension Font {
    static func drukTextBold(_ size: CGFloat, relative: TextStyle) -> Font {
        Font.custom("DrukTextWideCy-Bold", size: size, relativeTo: relative)
    }

    static func drukBold(_ size: CGFloat, relative: TextStyle) -> Font {
        Font.custom("Druk Wide Cyr Bold", size: size, relativeTo: relative)
    }

    static func drukMedium(_ size: CGFloat, relative: TextStyle) -> Font {
        Font.custom("Druk Wide Cyr Medium", size: size, relativeTo: relative)
    }

    static func suisseIntlBook(_ size: CGFloat, relative: TextStyle) -> Font {
        Font.custom("SuisseIntl-Book", size: size, relativeTo: relative)
    }

    static func suisseIntlRegular(_ size: CGFloat, relative: TextStyle) -> Font {
        Font.custom("SuisseIntl-Regular", size: size, relativeTo: relative)
    }
}
