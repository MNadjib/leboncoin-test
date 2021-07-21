//
//  NetworkProvider.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 15/07/2021.
//

import UIKit


protocol NetworkProviderInput {
    typealias Completion = ( Swift.Result<Data?, Error>) -> Void
    
    @discardableResult
    func request(_ endpoint: EndpointCases, _ completion: @escaping Completion) -> Cancellable?
}

class NetworkProvider {}

extension NetworkProvider: NetworkProviderInput  {

    typealias Completion = ( Swift.Result<Data?, Error>) -> Void
    
    @discardableResult
    func request(_ endpoint: EndpointCases, _ completion: @escaping Completion) -> Cancellable? {
        
        if !isNetworkAvailable {
            completion(.failure(.noNetwork))
            return nil
        }
        
        let urlSession = URLSession.shared
        
        var url = endpoint.url
        
        if let query = endpoint.query {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            var queryItems: [URLQueryItem] = []
            for key in query.keys {
                let queryItem = URLQueryItem(name: key, value: query[key])
                queryItems.append(queryItem)
            }
            urlComponents?.queryItems = queryItems
            url = urlComponents?.url ?? url
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = endpoint.method.rawValue
        
        /// not used in this case
        urlRequest.httpBody = endpoint.body
        
        if let headers = endpoint.headers {
            for key in headers.keys {
                urlRequest.setValue(headers[key], forHTTPHeaderField: key)
            }
        }
        
        let task = urlSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
            DispatchQueue.main.async {
                if error == nil, let httpResponse = urlResponse as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        completion(.success(data))
                    } else {
                        completion(.failure(.error(httpResponse.statusCode)))
                    }
                } else if let error = error {
                    completion(.failure(.otherServerError(error.localizedDescription)))
                } else  {
                    completion(.failure(.defaultError))
                }
            }
        }
        task.resume()
        return task
    }
    
    
    var isNetworkAvailable: Bool {
        NetworkStatus.shared.connection == .reachable
    }
}
