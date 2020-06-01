//
//  BookImageView.swift
//  BookStore
//
//  Created by Lucas Macedo de Lemos on 30/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import UIKit

class BookImageView: UIImageView {
    
    // MARK:- Properties
    
    private var task: URLSessionDataTask?
    private var downloading = false
    
    // MARK:- Public Methods
    
    public func downloadImage(with url: String?) {
        image = nil
        
        if downloading {
            cancelTask()
        }
        
        guard let urlString = url, let url = URL(string: urlString) else {
            return
        }
        
        downloading = true
        requestImage(from: url)
    }
    
    // MARK:- Private Methods
    
    private func requestImage(from url: URL) {
        task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async() {
                    self?.image = nil
                }
                
                return
            }
            
            DispatchQueue.main.async() {
                self?.image = UIImage(data: data)
            }
            
            self?.downloading = false
        })
        
        task?.resume()
    }
    
    private func cancelTask() {
        task?.cancel()
    }
}
