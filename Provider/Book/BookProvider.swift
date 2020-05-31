//
//  BookProvider.swift
//  Provider
//
//  Created by Lucas Macedo de Lemos on 29/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

open class BookProvider {
    
    // MARK:- Properties
    
    private var request: RequestProtocol
    private let baseURL = "https://www.googleapis.com/books"
    private let volumesEndpoint = "/v1/volumes"
    
    // MARK:- Init
    
    public init(request: RequestProtocol = Request()) {
        self.request = request
    }
    
    // MARK:- Open Methods
    
    open func fetchBooks(parameters: [String: String]?, completionHandler: @escaping (Data?, Error?) -> Void) {
                
        let url = "\(baseURL)\(volumesEndpoint)"
        
        request.make(url: url, method: .GET, parameters: parameters) { (data, response, error) in
            completionHandler(data, error)
        }
    }
}
