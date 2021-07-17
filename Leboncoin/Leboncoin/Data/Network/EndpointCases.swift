//
//  NetworkApi.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 15/07/2021.
//

import UIKit

enum EndpointCases {
    case classifiedAds
    case categories
}

extension EndpointCases: Endpoint {
    
    var baseURL: URL {
        return URL(string: Environment.serverUrl.value)!
    }

    var path: String {
        switch self {
        case .classifiedAds:
            return "listing.json"
        case .categories:
            return "categories.json"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }

    var query: [String : String]? {
        return nil
    }
    
    var body: Data? {
        return nil
    }
    
    var sampleData: Data {
        return Data()
    }
}
