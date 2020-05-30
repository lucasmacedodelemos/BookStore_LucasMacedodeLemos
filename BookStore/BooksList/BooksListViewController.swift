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
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        
        booksListManager.fetchBooks(question: "ios", page: self.page)
    }
    
    private func registerCell() {
        collectionView.register(UINib.init(nibName: "BookCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "bookCell")
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
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            if let cell = collectionView.cellForItem(at: indexPath) as? BookCollectionViewCell {
                cell.transform = .init(scaleX: 0.95, y: 0.95)
            }
        }, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3, delay: 0.2, options: UIViewAnimationOptions.curveEaseOut, animations: {
            if let cell = collectionView.cellForItem(at: indexPath) as? BookCollectionViewCell {
                cell.transform = .identity
                cell.contentView.backgroundColor = .clear
            }
        }, completion: nil)
    }
}

