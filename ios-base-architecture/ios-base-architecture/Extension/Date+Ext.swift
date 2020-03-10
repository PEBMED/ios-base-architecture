//
//  Date+Ext.swift
//  ios-base-architecture
//
//  Created by Luiz on 25/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

extension Date {
    func convertToMonthDayYearFormat() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
}
