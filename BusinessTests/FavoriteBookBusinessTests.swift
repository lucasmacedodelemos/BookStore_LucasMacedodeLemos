//
//  FavoriteBookBusiness.swift
//  BusinessTests
//
//  Created by Lucas Macedo de Lemos on 31/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Model
import XCTest
@testable import Business

class FavoriteBookBusinessTests: XCTestCase {

    func testSaveFavoriteBook() {
        
        var response: Book?
        
        let favoriteBookBusiness = FavoriteBookBusiness()
        
        let bookId = "12345678"
        let book = createBook(bookId: bookId)
        
        let _ = favoriteBookBusiness.save(book)
        
        response = favoriteBookBusiness.recover(withKey: bookId)
        XCTAssertNotNil(response)
        
        favoriteBookBusiness.remove(withKey: bookId)
        
        response = favoriteBookBusiness.recover(withKey: bookId)
        XCTAssertNil(response)
    }
    
    func testRecoverAllBook() {
        
        var response: [Book?]
        
        let favoriteBookBusiness = FavoriteBookBusiness()
        
        let bookId = "12345678"
        let book = createBook(bookId: bookId)
        let _ = favoriteBookBusiness.save(book)
        
        response = favoriteBookBusiness.recoverAll()
        
        XCTAssertTrue(response.count > 0)
        
        favoriteBookBusiness.remove(withKey: bookId)
    }
    
    private func createBook(bookId: String) -> Book {
        let imageLinks = ImageLinks(thumbnail: "url")
        let volumeInfo = VolumeInfo(title: "iOS", authors: nil, description: nil, imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: "url")
        return Book(bookId: bookId, volumeInfo: volumeInfo, saleInfo: saleInfo)
    }

}
