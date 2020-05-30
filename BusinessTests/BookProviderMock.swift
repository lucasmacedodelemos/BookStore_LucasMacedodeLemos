//
//  BookProviderMock.swift
//  BusinessTests
//
//  Created by Lucas Macedo de Lemos on 30/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation
import Provider

public class BookProviderMock: BookProvider {
    
    public override func fetchBooks(parameters: [String : String]?, completionHandler: @escaping (Data?, Error?) -> Void) {
        
        if let path = Bundle.init(for: BookProviderMock.self).path(forResource: "books", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                completionHandler(data, nil)
            } catch {
                completionHandler(nil, NSError(domain: "Cannot convert to Data", code: 0, userInfo: nil))
            }
        } else {
            completionHandler(nil, NSError(domain: "File not found", code: 0, userInfo: nil))
        }
    }
}
