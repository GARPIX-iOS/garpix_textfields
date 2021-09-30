//
//  TextFieldSampleView.swift
//  
//
//  Created by Anton Vlezko on 29.07.2021.
//

import SwiftUI
import GXUtilz

// MARK: - View

/// Тестовая View для того чтобы посмотреть на разные варианты применения текстфилдов
public struct TextFieldSampleView: View {
    @State private var text: String = ""
    @State private var isValidText: Bool = false
    @State private var showBottomError: Bool = false
    @State private var lineColor: Color = .black
    @State private var textBorderStyle: BorderStyles = BorderStyles.standart
    @State private var textIsEditing: Bool = false
    
    @State private var cardNumber: String = ""
    @State private var cardNumberBorderStyle: BorderStyles = BorderStyles.standart
    @State private var cardNumberIsEditing: Bool = false
    
    @State private var dollarPrice: Int? = nil
    @State private var dollarPriceBorderStyle: BorderStyles = BorderStyles.standart
    @State private var dollarPriceIsEditing: Bool = false
    
    @State private var dateString: String? = nil
    @State private var dateBorderStyle: BorderStyles = BorderStyles.standart
    @State private var dateIsEditing: Bool = false
    
    private var label: String = "Label"
    private var placeholder: String = "Placeholder"
    private var image: String = "chevron.left"
    
    public init() {
        
    }
    
    public var body: some View {
        ScrollView {
            standartTextField
            //            currencyTextField
                        dateTextField
        }
        .padding(.vertical, 30)
    }
}

// MARK: - TextFieldSampleView - StandartTextField realization

public extension TextFieldSampleView {
    var standartTextField: some View {
        VStack(spacing: 20) {
            materialTF
            //            tenSymbolsLimitTF
            //            cardNumberTF
        }
        .padding(.bottom, 20)
    }
    
    var materialTF: some View {
        StandartTextField(
            text: $text,
            placeholderColor: .gray,
            placeholder: "Введите текст",
            formatType: .init(onChangeOfText: { value in
                withAnimation {
                    statusCalculator(text: value)
                }
            })
        )
            .underlinedTFStyle(
                color: lineColor,
                height: 1
            )
            .customTFVerticalContent(
                isShowTopContent: .constant(true),
                isShowBottomContent: $showBottomError,
                topContent: {
                    HStack {
                        Text("Ключевые слова")
                            .padding(.leading, 12)
                        Spacer()
                    }
                },
                bottomContent: {
                    HStack {
                        Text("Кажется ты не ввел 10 символов, как мы договаривались, так что и я в благородство играть не буду")
                            .padding(.leading, 12)
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
            )
            .frame(width: UIScreen.main.bounds.width * 0.9)
    }
    
    func statusCalculator(text: String) {
        if text.count <= 10 {
            if text.isEmpty {
                showBottomError = false
                isValidText = false
            } else {
                showBottomError = true
                isValidText = false
            }
        } else {
            showBottomError = false
            isValidText = false
        }
        showBottomError ? (lineColor = .red) : (lineColor = .gray)
    }
    
    var tenSymbolsLimitTF: some View {
        StandartTextField(
            text: $text,
            placeholder: placeholder,
            formatType: CustomTFFormatType(onChangeOfText: { value in
                text = value.formatText(mask: "(X - X - X) X",
                                        symbol: "X",
                                        inputType: StringInputType(
                                            formatLanguage: .eng,
                                            containsText: true,
                                            containsNumbers: false,
                                            containsSpecialSymbols: false)
                )
            })
        )
            .underlinedTFStyle(color: .red)
            .customTFHorizontalContent(
                isShowLeadingContent: .constant(true),
                isShowTrailingContent: .constant(true),
                leadingContent: {
                    leadingButtons
                },
                trailingContent: {
                    clearTextButton
                }
            )
    }
    
    var cardNumberTF: some View {
        StandartTextField(
            text: $cardNumber,
            textColor: Color(.label),
            isEditing: $cardNumberIsEditing,
            placeholder: placeholder,
            onChangeOfIsEditing: { value in
                cardNumberBorderStyle = value ? .selected : .standart
            },
            hideKeyboard: {
                cardNumberIsEditing = false
            }
        )
            .borderTFStyle(
                borderStyle: $cardNumberBorderStyle,
                showLabel: $cardNumberIsEditing,
                title: label,
                image: image,
                textColor: .red
            )
            .customTFHorizontalContent(
                isShowTrailingContent: .constant(true),
                trailingContent: {
                    clearCardNumberButton
                }
            )
    }
}

// MARK: - TextFieldSampleView - NumbersTextField realization
public extension TextFieldSampleView {
    var currencyTextField: some View {
        
        let bindingTotalInput = Binding<Double?>(
            get: { self.dollarPrice.optIntToOptDouble() },
            set: { self.dollarPrice = $0.optDoubleToOptInt() }
        )
        
        return CurrencyTextField(
            totalInput: bindingTotalInput,
            currencySymbol: "$",
            textColor: Color(.label),
            isEditing: $dollarPriceIsEditing,
            placeholder: placeholder,
            onChangeOfIsEditing: { value in
                dollarPriceBorderStyle = value ? .selected : .standart
            },
            hideKeyboard: {
                dollarPriceIsEditing = false
            }
        )
            .customTFHorizontalContent(
                isShowTrailingContent: .constant(true),
                trailingContent: {
                    clearNumberButton
                }
            )
            .borderTFStyle(
                borderStyle: $dollarPriceBorderStyle,
                showLabel: $dollarPriceIsEditing,
                title: label,
                image: image,
                textColor: .red
            )
            .padding(.bottom, 20)
    }
}

// MARK: - TextFieldSampleView - DateTextField realization
public extension TextFieldSampleView {
    var dateTextField: some View {
        let timeDateFormat: DateFormats = .timeWithDigits
        let bindingDate = Binding<Date?>(
            get: { self.dateString?.stringToDate(dateFormat: timeDateFormat) },
            set: { self.dateString = $0?.dateToString(dateFormat: timeDateFormat) }
        )
        
        return DateTextField(
            date: bindingDate,
            formatter: .ddMMyyyy,
            textColor: .orange,
            placeholderColor: .gray,
            isEditing: $dateIsEditing,
            placeholder: placeholder,
            onChangeOfIsEditing: { value in
                dateBorderStyle = value ? .selected : .standart
            }
        )
            .customTFHorizontalContent(
                isShowTrailingContent: .constant(true),
                trailingContent: {
                    clearDateButton
                }
            )
            .borderTFStyle(
                borderStyle: $dateBorderStyle,
                showLabel: $dateIsEditing,
                title: label,
                image: image,
                textColor: .red
            )
            .onHideKeyboard {
                dateIsEditing = false
            }
            .padding(.bottom, 20)
    }
}


// MARK: - TextFieldSampleView - Buttons realization
public extension TextFieldSampleView {
    var leadingButtons: some View {
        Image(systemName: "gamecontroller")
            .renderingMode(.template)
            .foregroundColor(.red)
            .frame(width: 15, height: 15, alignment: .center)
    }
    
    var trailingButtons: some View {
        Image(systemName: "gamecontroller")
            .renderingMode(.template)
            .foregroundColor(Color(.label))
            .frame(width: 15, height: 15, alignment: .center)
    }
    
    var clearCardNumberButton: some View {
        ClearTextButton(clearingText: $cardNumber)
    }
    
    var clearTextButton: some View {
        ClearTextButton(clearingText: $text)
    }
    
    var clearNumberButton: some View {
        Button(action: {
            dollarPrice = nil
        }) {
            Image(systemName: "xmark")
                .renderingMode(.template)
                .foregroundColor(Color(.label))
                .frame(width: 15, height: 15, alignment: .center)
        }
    }
    
    var clearDateButton: some View {
        Button(action: {
            dateString = nil
        }) {
            Image(systemName: "xmark")
                .renderingMode(.template)
                .foregroundColor(Color(.label))
                .frame(width: 15, height: 15, alignment: .center)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldSampleView()
    }
}
