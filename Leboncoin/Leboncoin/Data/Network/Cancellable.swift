//
//  Cancellable.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 15/07/2021.
//

import UIKit

protocol Cancellable {
    func cancelRequest()
}

extension URLSessionTask: Cancellable {
    
    func cancelRequest() {
        cancel()
    }
}
