//
//  BookProvider.swift
//  Provider
//
//  Created by Lucas Macedo de Lemos on 29/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

open class BookProvider {
    
    var request: RequestProtocol
    let baseURL = "https://www.googleapis.com/books"
    
    public init(request: RequestProtocol = Request()) {
        self.request = request
    }
    
    open func fetchBooks(parameters: [String: String]?, completionHandler: @escaping (Data?, Error?) -> Void) {
                
        let url = "\(baseURL)/v1/volumes"
        
        request.make(url: url, method: .GET, parameters: parameters) { (data, response, error) in
            completionHandler(data, error)
        }
    }
}
