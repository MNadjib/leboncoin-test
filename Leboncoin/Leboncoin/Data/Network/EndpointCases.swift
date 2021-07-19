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
    case image(urlString: String)
}

extension EndpointCases: Endpoint {
    
    var baseURL: URL {
        switch self {
        case .image(let urlString):
            return URL(string: urlString)!
        default:
            return URL(string: Environment.serverUrl.value)!
        }
    }

    var path: String {
        switch self {
        case .classifiedAds:
            return "listing.json"
        case .categories:
            return "categories.json"
        case .image:
            return ""
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String: String]? {
        switch self {
        case .image:
            return nil
        default:
            return ["Accept": "application/json"]
        }
        
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
