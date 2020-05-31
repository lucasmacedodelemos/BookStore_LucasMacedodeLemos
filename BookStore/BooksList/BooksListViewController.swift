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
    
    lazy var booksListManager = BooksListManager(delegate: self)
    private var books: [Book] = []
    private var page = 0
    private var question = ""
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func registerCell() {
        collectionView.register(UINib.init(nibName: "BookCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "bookCell")
    }
    
    private func fetchBooks() {
        if self.question.trimmingCharacters(in: .whitespaces).count == 0 {
            return
        }
        
        self.view.endEditing(true)
        booksListManager.fetchBooks(question: question, page: self.page)
    }
    
    private func resetCollectionView() {
        self.books.removeAll()
        self.collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "bookDetailsSegue" {
            let bookDetails = segue.destination as? BookDetailsViewController
            bookDetails?.book = sender as? Book
        }
    }
}

extension BooksListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resetCollectionView()
        self.question = searchBar.text ?? ""
        fetchBooks()
    }
}

extension BooksListViewController: BooksListManagerDelegate {
    func handleError(type: BooksListErrorType) {
        
    }
    
    func handleSuccess(type: BooksListSuccessType) {
        switch type {
        case let .success(books):
            self.books.append(contentsOf: books)

            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension BooksListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "bookDetailsSegue", sender: self.books[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "bookCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BookCollectionViewCell
        cell.configure(with: books[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let cellWidth = screenSize.width/2 - 30
        let cellHeight = cellWidth*1.6
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            if let cell = collectionView.cellForItem(at: indexPath) as? BookCollectionViewCell {
                cell.transform = .init(scaleX: 0.9, y: 0.9)
            }
        }, completion: nil)
        
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2, delay: 0.2, options: UIViewAnimationOptions.curveEaseOut, animations: {
            if let cell = collectionView.cellForItem(at: indexPath) as? BookCollectionViewCell {
                cell.transform = .identity
                cell.contentView.backgroundColor = .clear
            }
        }, completion: nil)
    }
}
