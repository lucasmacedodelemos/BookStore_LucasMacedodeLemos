//
//  FavoriteBookProviderTests.swift
//  ProviderTests
//
//  Created by Lucas Macedo de Lemos on 31/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import XCTest
@testable import Provider

class FavoriteBookProviderTests: XCTestCase {

    func testAddFavoriteBook() {
        
        var response: Data?
        let favoriteBookProvider = FavoriteBookProvider()
        let data = Data()
        
        favoriteBookProvider.add(data, withKey: "teste")
        
        response = favoriteBookProvider.recover(withKey: "teste")
        XCTAssertNotNil(response)
    }
    
    func testRecoverAll() {
        
        var response: [String: Data]?
        
        let favoriteBookProvider = FavoriteBookProvider()
        let data = Data()
        
        favoriteBookProvider.add(data, withKey: "teste")
        favoriteBookProvider.add(data, withKey: "teste1")
        
        response = favoriteBookProvider.recoverAll()
        
        XCTAssertTrue(response!.count > 1)
    }
}
