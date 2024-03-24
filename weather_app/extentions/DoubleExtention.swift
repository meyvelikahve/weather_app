//
//  DoubleExtention.swift
//  weather_app
//
//  Created by Recep Sevim on 21.03.2024.
//

import Foundation

extension Double{
    func toStringWithOneComma() -> String {
        return String(format: "%.1f", self)
    }
}
