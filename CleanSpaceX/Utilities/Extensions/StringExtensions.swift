//
//  StringExtensions.swift
//  CleanSpaceX
//
//  Created by Ahmed Iqbal on 3/23/22.
//

import Foundation

public extension String {
    var double: Double? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Double
    }
}
