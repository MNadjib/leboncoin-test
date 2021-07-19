//
//  Helper.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 18/07/2021.
//

import UIKit

func localize(_ value: String) -> String {
    return NSLocalizedString(value, comment: "")
}

func log(_ item: Any) {
    if (Int(Environment.enableLog.value) == 1) {
        print(item)
    }
}


let iso8601DateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter
}()

let mediumDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    formatter.locale = Locale.current
    return formatter
}()

let longDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
    formatter.locale = Locale.current
    return formatter
}()
