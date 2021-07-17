//
//  Error.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 16/07/2021.
//

import UIKit

enum Error: Swift.Error {
    case noNetwork
    case invalidURL
    case httpError400
    case httpError401
    case httpError403
    case httpError404
    case httpError417
    case httpError408
    case httpError500
    case otherServerError(_ description: String)
    case defaultError
    
    static func error(_ code: Int) -> Error {
        switch code {
        case 400:
           return .httpError400
        case 401:
           return .httpError401
        case 403:
            return .httpError403
        case 404:
            return .httpError404
        case 408:
            return .httpError408
        case 417:
            return .httpError417
        case 500:
            return .httpError500
        default:
            return .defaultError
        }
    }
}
