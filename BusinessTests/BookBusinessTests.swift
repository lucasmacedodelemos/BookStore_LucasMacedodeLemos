//
//  BookBusinessTests.swift
//  BusinessTests
//
//  Created by Lucas Macedo de Lemos on 30/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Model
import XCTest
@testable import Business

class BookBusinessTests: XCTestCase {

    func testSuccessBooksParse() {
        let expetacion = expectation(description: "Success parse books")
        var response: BooksResponse?
        
        let bookBusiness = BookBusiness(provider: BookProviderMock())
        
        bookBusiness.fetchBooks(question: "ios", page: 0) { (booksResponse) in
            response = booksResponse
            expetacion.fulfill()
        }
    
        waitForExpectations(timeout: 8, handler: nil)
        XCTAssertNotNil(response)
    }
}
