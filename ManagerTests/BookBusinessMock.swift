//
//  BookBusinessMock.swift
//  ManagerTests
//
//  Created by Lucas Macedo de Lemos on 30/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation
import Business
import Model

class BookBusinessMock: BookBusiness {
    
    override func fetchBooks(question: String, page: Int, completionHandler: @escaping (BooksResponse?) -> Void) {
        completionHandler(BooksResponse(totalItems: 20, items: nil))
    }
}
