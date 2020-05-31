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
    
    // MARK:- Properties
    
    private var provider: BookProvider
    private let maxResults = 20
    private let questionParameter = "q"
    private let maxResultsParameter = "maxResults"
    private let startIndexParameter = "startIndex"
    
    // MARK:- Init
    
    public init(provider: BookProvider = BookProvider()) {
        self.provider = provider
    }
    
    // MARK:- Open Methods
    
    open func fetchBooks(question: String, page: Int, completionHandler: @escaping (BooksResponse?) -> Void) {
        let startIndex = maxResults * page
        
        let parameters = [questionParameter: question, maxResultsParameter: String(maxResults), startIndexParameter: String(startIndex)]
                
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
