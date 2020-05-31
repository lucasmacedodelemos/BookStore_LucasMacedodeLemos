//
//  FavoriteBookProvider.swift
//  Provider
//
//  Created by Lucas Macedo de Lemos on 31/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

public class FavoriteBookProvider {
    
    // MARK:- Properties
    
    private let dictionaryKey = "books"
    
    // MARK:- Init
    
    public init() {}
    
    // MARK:- Public Methods
    
    public func add(_ data: Data, withKey key: String) {
        var dictionary: [String : Data] = recoverDictionary() ?? [:]
        dictionary[key] = data
        
        save(dictionary: dictionary)
    }
    
    public func remove(withKey key: String) {
        guard var dictionary = recoverAll() else {
            return
        }
        
        dictionary.removeValue(forKey: key)
        save(dictionary: dictionary)
    }
    
    public func recover(withKey key: String) -> Data? {
        let dictionary = recoverDictionary()
        return dictionary?[key]
    }
    
    public func recoverAll() -> [String: Data]? {
        return recoverDictionary()
    }
    
    private func recoverDictionary() -> [String: Data]? {
        return UserDefaults.standard.dictionary(forKey: dictionaryKey) as? [String : Data]
    }
    
    private func save(dictionary: [String: Data]) {
        UserDefaults.standard.setValue(dictionary, forKey: dictionaryKey)
        UserDefaults.standard.synchronize()
    }
}
