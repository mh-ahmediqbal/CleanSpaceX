//
//  GeneralUtility.swift
//  CleanSpaceX
//
//  Created by Ahmed Iqbal on 3/23/22.
//

import UIKit

enum MoneyFormatType {
    case prefix
    case postfix
    case none
}

class GeneralUtility: NSObject {
    
    static func getFormattedMoney(money: String, locale: String, isPrefix: MoneyFormatType, rounding: Int) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: locale)
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        formatter.usesGroupingSeparator = true
        formatter.decimalSeparator = "."
        formatter.maximumFractionDigits = rounding
        formatter.minimumFractionDigits = rounding
        let priceInNumber = NSNumber.init(value: money.double ?? 0)
        
        let formattedString = formatter.string(from: priceInNumber) ?? ""
        let symbol = locale
        switch isPrefix {
        case .prefix:
           
            let formattedStringWithSymbol = "\(symbol) " + formattedString
            return formattedStringWithSymbol
        case .postfix:
            let formattedStringWithSymbol = formattedString + " \(symbol)"
            return formattedStringWithSymbol
        case .none:
            let formattedStringWithSymbol = formattedString
            return formattedStringWithSymbol
        }
    }
    
    // MARK: Get Stub Response
    static func stubbedResponse(_ filename: String) -> Data! {
        guard let path = Bundle.main.path(forResource: filename, ofType: "json") else { fatalError("path could not be found") }
        return (try? Data(contentsOf: URL(fileURLWithPath: path)))
    }
}
