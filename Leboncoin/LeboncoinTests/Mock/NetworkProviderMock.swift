//
//  NetworkProviderMock.swift
//  LeboncoinTests
//
//  Created by Nadjib Bellouni on 21/07/2021.
//

import UIKit

enum TestCase {
    case providerError
    case providerHttpError
    case providerEmptyData
    case providerData
}

class NetworkProviderMock {
    var testCase: TestCase
    
    init(testCase: TestCase) {
        self.testCase = testCase
    }
    
}
extension NetworkProviderMock : NetworkProviderInput {
    
    func request(_ endpoint: EndpointCases, _ completion: @escaping Completion) -> Cancellable? {
        switch testCase {
        case .providerError:
            completion(.failure(.invalidURL))
        case .providerHttpError:
            completion(.failure(.httpError400))
        case .providerEmptyData:
            completion(.success("[]".data(using: .utf8)))
        case .providerData:
            completion(.success(endpoint.sampleData))
        }
        return URLSession.shared.dataTask(with: URL(string: "google.fr")!)
    }
}
