//
//  FavoriteBookManager.swift
//  Manager
//
//  Created by Lucas Macedo de Lemos on 31/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation
import Model
import Business

public class FavoriteBookManager {
    
    // MARK:- Properties
    
    private var business: FavoriteBookBusiness
    
    // MARK:- Init
    
    public init(business: FavoriteBookBusiness = FavoriteBookBusiness()) {
        self.business = business
    }
    
    // MARK:- Public Methods
    
    public func save(_ book: Book) -> Bool {
        return business.save(book)
    }
    
    public func remove(withKey key: String) {
        business.remove(withKey: key)
    }
    
    public func recover(withKey key: String) -> Book? {
        return business.recover(withKey: key)
    }
    
    public func recoverAll() -> [Book] {
        return business.recoverAll()
    }
}
