//
//  Book.swift
//  Model
//
//  Created by Lucas Macedo de Lemos on 30/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

public struct Book: Codable {
    
    public let bookId: String
    public let volumeInfo: VolumeInfo
    public let saleInfo: SaleInfo
    
    
    enum CodingKeys: String, CodingKey {
        case bookId = "id"
        case volumeInfo
        case saleInfo
    }
}
