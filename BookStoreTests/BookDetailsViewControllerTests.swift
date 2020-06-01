//
//  BookDetailsViewControllerTests.swift
//  BookStoreTests
//
//  Created by Lucas Macedo de Lemos on 31/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import XCTest
import Model
@testable import BookStore

class BookDetailsViewControllerTests: XCTestCase {
    
    func testPopulateView() {
        let bookDetails = makeBookDetails()
        bookDetails.book = createBook(bookId: "12345678")
        bookDetails.loadViewIfNeeded()
        bookDetails.viewWillAppear(false)
        
        XCTAssertFalse(bookDetails.buyView.isHidden)
        XCTAssertTrue(bookDetails.descriptionView.isHidden)
    }
    
    private func createBook(bookId: String) -> Book {
        let imageLinks = ImageLinks(thumbnail: "http://books.google.com/books/content?id=x6qjAwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api")
        let volumeInfo = VolumeInfo(title: "iOS", authors: nil, description: nil, imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: "https://play.google.com/store/books/details?id=ymJIyHcVbfsC&rdid=book-ymJIyHcVbfsC&rdot=1&source=gbs_api")
        return Book(bookId: bookId, volumeInfo: volumeInfo, saleInfo: saleInfo)
    }
    
    private func makeBookDetails() -> BookDetailsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let bookDetails = storyboard.instantiateViewController(identifier: "BookDetailsViewController") as! BookDetailsViewController
        return bookDetails
    }
}
