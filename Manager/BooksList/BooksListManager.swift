//
//  BooksListManager.swift
//  Manager
//
//  Created by Lucas Macedo de Lemos on 30/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation
import Business
import Model

// MARK:- Enum

public enum BooksListSuccessType {
    case success(books: [Book])
}

public enum BooksListErrorType {
    case error
}

// MARK:- Protocol

public protocol BooksListManagerDelegate: AnyObject {
    func handleError(type: BooksListErrorType)
    func handleSuccess(type: BooksListSuccessType)
}

public class BooksListManager {
    
    // MARK:- Properties
    
    private weak var delegate: BooksListManagerDelegate?
    private var business: BookBusiness

    // MARK:- Init
    
    public init(delegate: BooksListManagerDelegate, business: BookBusiness = BookBusiness()) {
        self.delegate = delegate
        self.business = business
    }

    // MARK:- Public Methods
    
    public func fetchBooks(question: String, page: Int) {
        
        business.fetchBooks(question: question, page: page) { [weak self] (booksResponse) in
            
            guard let booksResponse = booksResponse else {
                self?.delegate?.handleError(type: .error)
                return
            }
            
            guard let books = booksResponse.items else {
                self?.delegate?.handleSuccess(type: .success(books: []))
                return
            }
            
            self?.delegate?.handleSuccess(type: .success(books: books))
        }
    }
}
