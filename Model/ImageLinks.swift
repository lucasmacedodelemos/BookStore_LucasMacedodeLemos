//
//  ImageLinks.swift
//  Model
//
//  Created by Lucas Macedo de Lemos on 30/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

public struct ImageLinks: Codable {
    
    // MARK:- Properties
    
    public let thumbnail: String
    
    // MARK:- Init
    
    public init(thumbnail: String) {
        self.thumbnail = thumbnail
    }
}
