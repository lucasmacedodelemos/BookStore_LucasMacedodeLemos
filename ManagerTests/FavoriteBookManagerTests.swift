//
//  BookFavoriteManagerTests.swift
//  ManagerTests
//
//  Created by Lucas Macedo de Lemos on 31/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Model
import XCTest
@testable import Manager

class FavoriteBookManagerTests: XCTestCase {

    func testSaveFavoriteBook() {
        var response: Book?
        
        let favoriteBookManager = FavoriteBookManager()
        
        let bookId = "12345678"
        let book = createBook(bookId: bookId)
        
        let _ = favoriteBookManager.save(book)
        
        response = favoriteBookManager.recover(withKey: bookId)
        XCTAssertNotNil(response)
        
        favoriteBookManager.remove(withKey: bookId)
        
        response = favoriteBookManager.recover(withKey: bookId)
        XCTAssertNil(response)
    }
    
    func testRecoverAllBook() {
        
        var response: [Book?]
        
        let favoriteBookManager = FavoriteBookManager()
        
        let bookId = "12345678"
        let book = createBook(bookId: bookId)
        let _ = favoriteBookManager.save(book)
        
        response = favoriteBookManager.recoverAll()
        
        XCTAssertTrue(response.count > 0)
        
        favoriteBookManager.remove(withKey: bookId)
    }
    
    private func createBook(bookId: String) -> Book {
        let imageLinks = ImageLinks(thumbnail: "url")
        let volumeInfo = VolumeInfo(title: "iOS", authors: nil, description: nil, imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: "url")
        return Book(bookId: bookId, volumeInfo: volumeInfo, saleInfo: saleInfo)
    }
}
