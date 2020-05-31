//
//  BooksListManagerTests.swift
//  ManagerTests
//
//  Created by Lucas Macedo de Lemos on 30/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Model
import XCTest
@testable import Manager

class BooksListManagerTests: XCTestCase, BooksListManagerDelegate {
    
    var expetacion: XCTestExpectation?
    
    func testSuccessBooksObject() {
        expetacion = expectation(description: "Success books object")
        
        let bookBusiness = BooksListManager(delegate: self, business: BookBusinessMock())
        
        bookBusiness.fetchBooks(question: "ios", page: 0)
        waitForExpectations(timeout: 8, handler: nil)
    }
    
    func handleError(type: BooksListErrorType) {
        expetacion?.fulfill()
        
        switch type {
        case .error:
            XCTFail()
        }
    }
    
    func handleSuccess(type: BooksListSuccessType) {
        expetacion?.fulfill()
        
        switch (type) {
        case let .success(books):
            XCTAssertNotNil(books)
        }
    }
}
