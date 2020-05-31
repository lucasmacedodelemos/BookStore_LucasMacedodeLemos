//
//  FavoriteBookBusiness.swift
//  Business
//
//  Created by Lucas Macedo de Lemos on 31/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation
import Model
import Provider

public class FavoriteBookBusiness {
    
    private var provider: FavoriteBookProvider
    
    public init(provider: FavoriteBookProvider = FavoriteBookProvider()) {
        self.provider = provider
    }
    
    public func save(_ book: Book) -> Bool {
        
        guard let data = try? JSONEncoder().encode(book) else {
            return false
        }
        
        provider.add(data, withKey: book.bookId)
        
        return true
    }
    
    public func remove(withKey key: String) {
        provider.remove(withKey: key)
    }
    
    public func recover(withKey key: String) -> Book? {
        
        guard let data = provider.recover(withKey: key) else {
            return nil
        }
        
        let book: Book? = try? JSONDecoder().decode(Book.self, from: data)
        
        return book
    }
    
    public func recoverAll() -> [Book?] {
        
        guard let dictionary = provider.recoverAll() else {
            return []
        }
        
        let books = dictionary.map {
            try? JSONDecoder().decode(Book.self, from: $0.value)
        }
        
        return books
    }
}
