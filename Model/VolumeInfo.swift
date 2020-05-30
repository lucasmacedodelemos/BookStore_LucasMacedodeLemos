//
//  VolumeInfo.swift
//  Model
//
//  Created by Lucas Macedo de Lemos on 30/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

public struct VolumeInfo: Codable {
    
    public let title: String
    public let authors: [String]?
    public let description: String?
    public let imageLinks: ImageLinks
    
}
