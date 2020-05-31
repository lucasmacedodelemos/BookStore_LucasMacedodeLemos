//
//  BooksProviderTests.swift
//  ProviderTests
//
//  Created by Lucas Macedo de Lemos on 29/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import XCTest
@testable import Provider

class BookProviderTests: XCTestCase {

    func testFetchBooksNotNilExample() {
        let expetacion = expectation(description: "Fetch books not nil")
        var response: Data?
        let bookProvider = BookProvider(request: RequestMock())
        
        bookProvider.fetchBooks(parameters: nil) { (data, error) in
            response = data
            expetacion.fulfill()
        }
        
        waitForExpectations(timeout: 8, handler: nil)
        XCTAssertNotNil(response)
    }
}
