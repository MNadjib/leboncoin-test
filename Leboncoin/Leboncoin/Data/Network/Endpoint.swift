//
//  Endpoint.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 15/07/2021.
//

import UIKit

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

protocol Endpoint {
    
    var baseURL: URL { get }
    
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var headers: [String: String]? { get }
    
    var query: [String:String]? { get }
    
    var body: Data? { get }
    
    var sampleData: Data { get }
}

extension Endpoint {
    var url: URL {
        if !path.isEmpty {
            return baseURL.appendingPathComponent(path)
        }
        return baseURL
    }
}
