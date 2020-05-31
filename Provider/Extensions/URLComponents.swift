//
//  URLComponents.swift
//  Provider
//
//  Created by Lucas Macedo de Lemos on 29/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
