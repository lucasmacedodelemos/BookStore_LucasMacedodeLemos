//
//  BooksListViewControllerTests.swift
//  BookStoreTests
//
//  Created by Lucas Macedo de Lemos on 31/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import XCTest
import Model
@testable import BookStore


class BooksListViewControllerTests: XCTestCase {
    
    func testPopulateView() {
        
        let booksList = makeBooksList()
        booksList.books = [createBook(bookId: "teste")]
        booksList.loadViewIfNeeded()
        booksList.viewWillAppear(false)
        
        let cell = booksList.collectionView.dataSource?.collectionView(booksList.collectionView, cellForItemAt: IndexPath(item: 0, section: 0))
        
        XCTAssertNotNil(cell)
    }
    
    private func createBook(bookId: String) -> Book {
        let imageLinks = ImageLinks(thumbnail: "http://books.google.com/books/content?id=x6qjAwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api")
        let volumeInfo = VolumeInfo(title: "iOS", authors: nil, description: nil, imageLinks: imageLinks)
        let saleInfo = SaleInfo(buyLink: "https://play.google.com/store/books/details?id=ymJIyHcVbfsC&rdid=book-ymJIyHcVbfsC&rdot=1&source=gbs_api")
        return Book(bookId: bookId, volumeInfo: volumeInfo, saleInfo: saleInfo)
    }
    
    private func makeBooksList() -> BooksListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let booksList = storyboard.instantiateViewController(identifier: "BooksListViewController") as! BooksListViewController
        return booksList
    }
    
}
