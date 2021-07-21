//
//  BorderTFStyle + Extension.swift
//  
//
//  Created by Anton Vlezko on 21.07.2021.
//

import SwiftUI

public extension View {
    func borderTFStyle(components: BorderTFStyleComponents) -> some View {
        modifier(BorderTFStyle(components: components))
    }
}
