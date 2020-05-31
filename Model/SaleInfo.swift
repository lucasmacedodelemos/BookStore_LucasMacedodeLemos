//
//  File.swift
//  Model
//
//  Created by Lucas Macedo de Lemos on 30/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

public struct SaleInfo: Codable {
    
    // MARK:- Properties
    
    public let buyLink: String?
    
    // MARK:- Init
    
    public init(buyLink: String?) {
        self.buyLink = buyLink
    }
}
