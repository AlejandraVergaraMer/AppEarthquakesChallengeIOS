//
//  DateManager.swift
//  AppEarthquakesChallengeIOS
//
//  Created by Alejandra Vergara Meriño on 28-02-24.
//

import Foundation

struct DateManager {
    static func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }

    static func getCurrentDate() -> String {
        let date = Date()
        return formatDate(date)
    }
    
    static func getPreviousDate() -> Date {
        guard let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else { return Date() }
        return previousDay
    }

    static func getNextDate() -> Date {
        guard let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: Date()) else { return Date() }
        return nextDay
    }
    
    static func getCurrentDate() -> Date {
        return Date()
    }
}
