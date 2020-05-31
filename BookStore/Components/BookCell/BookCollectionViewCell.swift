//
//  BookCollectionViewCell.swift
//  BookStore
//
//  Created by Lucas Macedo de Lemos on 30/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import UIKit
import Model

class BookCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bookImageView: BookImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with book: Book) {
        bookImageView.downloadImage(with: book.volumeInfo.imageLinks.thumbnail)
        setupLayout()
    }
    
    private func setupLayout() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
        self.clipsToBounds = false
    }
}
