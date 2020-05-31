//
//  Book.swift
//  Model
//
//  Created by Lucas Macedo de Lemos on 30/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

public struct Book: Codable {
    
    // MARK:- Properties
    
    public let bookId: String
    public let volumeInfo: VolumeInfo
    public let saleInfo: SaleInfo
    
    // MARK:- Init
    
    public init(bookId: String, volumeInfo: VolumeInfo, saleInfo: SaleInfo) {
        self.bookId = bookId
        self.volumeInfo = volumeInfo
        self.saleInfo = saleInfo
    }
    
    // MARK:- Enum
    
    enum CodingKeys: String, CodingKey {
        case bookId = "id"
        case volumeInfo
        case saleInfo
    }
}
