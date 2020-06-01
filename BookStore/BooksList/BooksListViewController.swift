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

// MARK:- Enum
enum SectionType: Int {
    case book
    case indicator
}

enum IndicatorStatus {
    case hasMore
    case loading
    case finished
}


class BooksListViewController: UIViewController {
    
    // MARK:- Properties
    
    lazy var booksListManager = BooksListManager(delegate: self)
    private var books: [Book] = []
    private var page = 0
    private var question = ""
    private var indicatorStatus: IndicatorStatus = .finished
    private let bookDetailsSegue = "bookDetailsSegue"
    private let bookCellIdentifier = "bookCell"
    private let indicatorCellIdentifier = "indicatorCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var startView: UIView!
    
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
        view.endEditing(true)

        if question.trimmingCharacters(in: .whitespaces).count == 0 {
            resetCollectionView()
            return
        }
        
        booksListManager.fetchBooks(question: question, page: self.page)
    }
    
    private func updateCollectionView(withBooks books: [Book]) {
        if books.count == 0 || self.books.count == 0 {
            indicatorStatus = books.count == 0 ? .finished : .hasMore
            
            self.books.append(contentsOf: books)
            
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        } else {
            indicatorStatus = .hasMore
            self.books.append(contentsOf: books)
            
            let indexPaths = ((self.books.count - books.count)...(self.books.count - 1)).map {
                IndexPath(row: $0, section: 0)
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.performBatchUpdates({
                    self?.collectionView.insertItems(at: indexPaths)
                    self?.collectionView.reloadSections(IndexSet(integer: 1))
                }, completion: nil)
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.loadingView.isHidden = true
            
            if self?.books.count == 0 {
                self?.resetCollectionView()
                self?.createAlert(withMessage: "No book found.")
            }
        }
    }
    
    private func resetCollectionView() {
        startView.isHidden = false
        loadingView.isHidden = true
        books.removeAll()
        page = 0
        indicatorStatus = .finished
        collectionView.reloadData()
    }
    
    private func createAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Ops", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        navigationController?.present(alert, animated: true, completion: nil)
    }
}

// MARK:- Search bar delegate

extension BooksListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resetCollectionView()
        loadingView.isHidden = false
        startView.isHidden = true
        question = searchBar.text ?? ""
        fetchBooks()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
}

// MARK:- Book list manager delegate

extension BooksListViewController: BooksListManagerDelegate {
    func handleError(type: BooksListErrorType) {
        DispatchQueue.main.async { [weak self] in
            self?.resetCollectionView()
            self?.createAlert(withMessage: "Something went wrong.")
        }
    }
    
    func handleSuccess(type: BooksListSuccessType) {
        switch type {
        case let .success(books):
            updateCollectionView(withBooks: books)
        }
    }
}

// MARK:- Collection view delegate and data source

extension BooksListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: bookDetailsSegue, sender: self.books[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let sectionType = SectionType(rawValue: section)
        
        if sectionType == SectionType.book {
            return books.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionType = SectionType(rawValue: indexPath.section)
        
        if sectionType == SectionType.book {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bookCellIdentifier, for: indexPath) as! BookCollectionViewCell
            cell.configure(with: books[indexPath.row])
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: indicatorCellIdentifier, for: indexPath)
            
            if indicatorStatus != .loading {
                indicatorStatus = .loading
                page += 1
                fetchBooks()
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let screenSize: CGRect = UIScreen.main.bounds
        let sectionType = SectionType(rawValue: indexPath.section)

        if sectionType == SectionType.book {
            let cellWidth = screenSize.width/2 - 30
            let cellHeight = cellWidth*1.6

            return CGSize(width: cellWidth, height: cellHeight)
        } else {
            let cellWidth = screenSize.width - 40
            let cellHeight: CGFloat = 60

            return CGSize(width: cellWidth, height: cellHeight)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return indicatorStatus == .finished ? 1 : 2
    }
}
