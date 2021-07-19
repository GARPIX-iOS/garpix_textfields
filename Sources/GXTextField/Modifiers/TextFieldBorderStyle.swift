//
//  TextFieldBorderStyle.swift
//  Red
//
//  Created by Danil Lomaev on 26.03.2021.
//

import Foundation
import SwiftUI

protocol TextFieldBorderStyleProtocol {
    var title: String { get set }
    var image: String { get set }
    var type: BorderStyles { get set }
    init(title: String, image: String, type: BorderStyles)
}

struct TextFieldBorderStyle: ViewModifier, TextFieldBorderStyleProtocol {
    var title: String = ""
    var image: String = ""
    var type: BorderStyles = .standart
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ZStack(alignment: .topLeading) {
                    switch type {
                    case .standart:
                        Group {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                            if !title.isEmpty {
                                HStack {
                                    Text(title)
                                        .font(.suisseIntlBook(12, relative: .caption))
                                    if !image.isEmpty {
                                        Image(systemName: image)
                                    }
                                }
                                .font(.caption2)
                                .foregroundColor(Color.gray)
                                .padding(2)
                                .background(Color.white)
                                .offset(x: 10, y: -8)
                            }
                        }
                    case .selected:
                        Group {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                            if !title.isEmpty {
                                HStack {
                                    Text(title)
                                        .font(.suisseIntlBook(12, relative: .caption))
                                    if !image.isEmpty {
                                        Image(systemName: image)
                                    }
                                }
                                .font(.caption2)
                                .foregroundColor(Color.black)
                                .padding(2)
                                .background(Color.white)
                                .offset(x: 10, y: -8)
                            }
                        }
                    case .error:
                        Group {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.red, lineWidth: 1)
                            if !title.isEmpty {
                                HStack {
                                    Text(title)
                                        .font(.suisseIntlBook(12, relative: .caption))
                                    if !image.isEmpty {
                                        Image(systemName: image)
                                    }
                                }
                                .font(.caption2)
                                .foregroundColor(Color.red)
                                .padding(2)
                                .background(Color.white)
                                .offset(x: 10, y: -8)
                            }
                        }
                    }
                }
            )
    }
}

extension View {
    func textFieldBorderStyle(type: BorderStyles, title: String, image: String) -> some View {
        modifier(TextFieldBorderStyle(title: title, image: image, type: type))
    }
}
