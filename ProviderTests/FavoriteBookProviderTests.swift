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
        let key = "teste"
        
        favoriteBookProvider.add(data, withKey: key)
        
        response = favoriteBookProvider.recover(withKey: key)
        XCTAssertNotNil(response)

        favoriteBookProvider.remove(withKey: key)
    
        response = favoriteBookProvider.recover(withKey: key)
        XCTAssertNil(response)
    }
    
    func testRecoverAll() {
        
        var response: [String: Data]?
        
        let favoriteBookProvider = FavoriteBookProvider()
        let data = Data()
        let key = "teste"
        let key1 = "teste1"

        
        favoriteBookProvider.add(data, withKey: key)
        favoriteBookProvider.add(data, withKey: key1)
        
        response = favoriteBookProvider.recoverAll()
        
        XCTAssertTrue(response!.count > 1)
        
        favoriteBookProvider.remove(withKey: key)
        favoriteBookProvider.remove(withKey: key1)
        
        response = favoriteBookProvider.recoverAll()
        
        XCTAssertTrue(response?.count == 0)
    }
}
