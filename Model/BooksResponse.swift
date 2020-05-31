//
//  BooksResponse.swift
//  Model
//
//  Created by Lucas Macedo de Lemos on 30/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

public struct BooksResponse: Codable {
    
    // MARK:- Properties
    
    public let totalItems: Int
    public let items: [Book]?
    
    // MARK:- Init
    
    public init(totalItems: Int, items: [Book]?) {
        self.totalItems = totalItems
        self.items = items
    }
}
