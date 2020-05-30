//
//  BookBusiness.swift
//  Business
//
//  Created by Lucas Macedo de Lemos on 30/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation
import Provider
import Model

open class BookBusiness {
    
    var provider: BookProvider
    
    public init(provider: BookProvider = BookProvider()) {
        self.provider = provider
    }
    
    open func fetchBooks(question: String, page: Int, completionHandler: @escaping (BooksResponse?) -> Void) {
        let maxResults = 20
        let startIndex = maxResults * page
        
        let parameters = ["q": question, "maxResults": String(maxResults), "startIndex": String(startIndex)]
                
        provider.fetchBooks(parameters: parameters) { (data, error) in
            guard let data = data else {
                completionHandler(nil)
                return
            }
            
            let booksResponse: BooksResponse? = try? JSONDecoder().decode(BooksResponse.self, from: data)
            completionHandler(booksResponse)
        }
    }
}
