//
//  BookDetailsViewController.swift
//  BookStore
//
//  Created by Lucas Macedo de Lemos on 30/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import UIKit
import Model
import SafariServices
import Manager

class BookDetailsViewController: UIViewController {

    // MARK:- Properties
    
    var book: Book?
    
    lazy var favoriteBookManager = FavoriteBookManager()
    private var isFavorited = false
    
    @IBOutlet weak var bookImageView: BookImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var buyView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    
    // MARK:- Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
        
        populateBook()
    }
    
    // MARK:- Actions
    
    @IBAction func favoriteButtonDidTap(_ sender: UIBarButtonItem) {
        favoriteBook()
        changeFavoriteButtonStatus()
    }
    
    @IBAction func buyButtonDidTap(_ sender: Any) {
        guard let buyLink = book?.saleInfo.buyLink, let url = URL(string: buyLink) else {
            return
        }
        
        let safari = SFSafariViewController(url: url)
        navigationController?.present(safari, animated: true, completion: nil)
    }
    
    // MARK:- Private Methods
        
    private func setupLayout() {
        bookImageView.layer.shadowColor = UIColor.black.cgColor
        bookImageView.layer.shadowOpacity = 0.3
        bookImageView.layer.shadowOffset = .zero
        bookImageView.layer.shadowRadius = 5
        bookImageView.clipsToBounds = false
    }
    
    private func populateBook() {
        
        if let bookId = book?.bookId {
            isFavorited = favoriteBookManager.recover(withKey: bookId) != nil
            changeFavoriteButtonStatus()
        }

        titleLabel.text = book?.volumeInfo.title
        authorsLabel.text = book?.volumeInfo.authors?.joined(separator: ", ")
        descriptionLabel.text = book?.volumeInfo.description
        
        if let description = book?.volumeInfo.description {
            descriptionLabel.text = description
        } else {
            descriptionView.isHidden = true
        }
        
        if let thumbnail = book?.volumeInfo.imageLinks?.thumbnail {
            bookImageView.downloadImage(with: thumbnail)
        }
        
        if book?.saleInfo.buyLink == nil {
            buyView.isHidden = true
        }
    }
    
    private func changeFavoriteButtonStatus() {
        let favoriteButton = navigationItem.rightBarButtonItem
        
        if isFavorited {
            favoriteButton?.image = UIImage(systemName: "star.fill")
        } else {
            favoriteButton?.image = UIImage(systemName: "star")
        }
    }
    
    private func favoriteBook() {
        guard let book = self.book else {
            return
        }
        
        if isFavorited {
            favoriteBookManager.remove(withKey: book.bookId)
            isFavorited = false
        } else {
            isFavorited = favoriteBookManager.save(book)
        }
    }
}
