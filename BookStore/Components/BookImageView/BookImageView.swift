//
//  BookImageView.swift
//  BookStore
//
//  Created by Lucas Macedo de Lemos on 30/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import UIKit

class BookImageView: UIImageView {
    
    private var task: URLSessionDataTask?
    private var downloading = false
    
    func downloadImage(with url: String) {
        self.image = nil
        
        if downloading {
            cancelTask()
        }
        
        guard let url = URL(string: url) else {
            return
        }
        
        self.downloading = true
        requestImage(from: url)
    }
    
    func requestImage(from url: URL) {
        self.task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async() { [weak self] in
                    self?.image = nil
                }
                
                return
            }
            
            DispatchQueue.main.async() {
                self?.image = UIImage(data: data)
            }
            
            self?.downloading = false
        })
        
        self.task?.resume()
    }
    
    func cancelTask() {
        task?.cancel()
    }
}
