//
//  FavoriteBooksListViewController.swift
//  BookStore
//
//  Created by Lucas Macedo de Lemos on 31/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import UIKit
import Manager
import Model

class FavoriteBooksListViewController: UIViewController {

    // MARK:- Properties
    
    lazy var favoriteBookManager = FavoriteBookManager()
    internal var books: [Book] = []
    private let bookCellIdentifier = "bookCell"
    private let favoriteBookDetailsSegue = "favoriteBookDetailsSegue"

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noFavoriteBookView: UIView!

    // MARK:- Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        fetchFavoriteBooks()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == favoriteBookDetailsSegue {
            let bookDetails = segue.destination as? BookDetailsViewController
            bookDetails?.book = sender as? Book
        }
    }
    
    // MARK:- Private Methods
    
    private func registerCell() {
        collectionView.register(UINib.init(nibName: String(describing: BookCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: bookCellIdentifier)
    }
    
    private func fetchFavoriteBooks() {
        books = favoriteBookManager.recoverAll()
        reloadData()
    }
    
    private func reloadData() {
        noFavoriteBookView.isHidden = books.count > 0
        collectionView.reloadData()
    }
}

// MARK:- Collection view delegate and data source

extension FavoriteBooksListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: favoriteBookDetailsSegue, sender: self.books[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bookCellIdentifier, for: indexPath) as! BookCollectionViewCell
        cell.configure(with: books[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let cellWidth = screenSize.width/2 - 30
        let cellHeight = cellWidth*1.6
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
