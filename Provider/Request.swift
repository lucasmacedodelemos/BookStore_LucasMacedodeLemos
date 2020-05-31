//
//  Request.swift
//  Provider
//
//  Created by Lucas Macedo de Lemos on 29/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

public protocol RequestProtocol {
    
    func make(url: String,
              method: HTTPMethod,
              parameters: [String: String]?,
              completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

public enum HTTPMethod: String {
    case GET
}

public class Request: RequestProtocol {
    
    public init() {}
    
    public func make(url: String,
                     method: HTTPMethod,
                     parameters: [String: String]?,
                     completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        switch method {
        case .GET:
            get(url: url, parameters: parameters, completionHandler: completionHandler)
        }
    }
    
    private func get(url: String,
                     parameters: [String: String]?,
                     completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        var urlComponents = URLComponents(string: url)
        urlComponents?.setQueryItems(with: parameters ?? [:])
        
        guard let url = urlComponents?.url else {
            completionHandler(nil, nil, NSError(domain: "failed parse url", code: 0, userInfo: nil))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: completionHandler)
        task.resume()
    }
}
