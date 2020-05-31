//
//  FirstViewController.swift
//  BookStore
//
//  Created by Lucas Macedo de Lemos on 29/05/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import UIKit
import Model
import Manager

class BooksListViewController: UIViewController {
    
    // MARK:- Properties
    
    lazy var booksListManager = BooksListManager(delegate: self)
    private var books: [Book] = []
    private var page = 0
    private var question = ""
    private let bookDetailsSegue = "bookDetailsSegue"
    private let bookCellIdentifier = "bookCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK:- Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == bookDetailsSegue {
            let bookDetails = segue.destination as? BookDetailsViewController
            bookDetails?.book = sender as? Book
        }
    }
    
    // MARK:- Private Methods
    
    private func registerCell() {
        collectionView.register(UINib.init(nibName: String(describing: BookCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: bookCellIdentifier)
    }
    
    private func fetchBooks() {
        if question.trimmingCharacters(in: .whitespaces).count == 0 {
            return
        }
        
        view.endEditing(true)
        booksListManager.fetchBooks(question: question, page: self.page)
    }
    
    private func resetCollectionView() {
        books.removeAll()
        collectionView.reloadData()
    }
}

// MARK:- Search bar delegate

extension BooksListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resetCollectionView()
        question = searchBar.text ?? ""
        fetchBooks()
    }
}

// MARK:- Book list manager delegate

extension BooksListViewController: BooksListManagerDelegate {
    func handleError(type: BooksListErrorType) {
        
    }
    
    func handleSuccess(type: BooksListSuccessType) {
        switch type {
        case let .success(books):
            self.books.append(contentsOf: books)

            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK:- Collection view delegate and data source

extension BooksListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: bookDetailsSegue, sender: self.books[indexPath.row])
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
