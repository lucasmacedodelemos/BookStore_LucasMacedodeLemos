//
//  RequestMock.swift
//  ProviderTests
//
//  Created by Lucas Macedo de Lemos on 29/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation
@testable import Provider


class RequestMock: RequestProtocol {
    
    func make(url: String, method: HTTPMethod, parameters: [String : String]?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completionHandler(Data(), nil, nil)
    }
}
