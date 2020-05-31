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

class BookDetailsViewController: UIViewController {

    var book: Book?
    
    @IBOutlet weak var bookImageView: BookImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var buyView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateBook()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func populateBook() {
        
        titleLabel.text = book?.volumeInfo.title
        authorsLabel.text = book?.volumeInfo.authors?.joined(separator: ", ")
        descriptionLabel.text = book?.volumeInfo.description
        
        if let description = book?.volumeInfo.description {
            descriptionLabel.text = description
        } else {
            descriptionView.isHidden = true
        }
        
        if let thumbnail = book?.volumeInfo.imageLinks.thumbnail {
            bookImageView.downloadImage(with: thumbnail)
        }
        
        if book?.saleInfo.buyLink == nil {
            buyView.isHidden = true
        }
    }
    
    @IBAction func buyButtonDidTap(_ sender: Any) {
        guard let buyLink = book?.saleInfo.buyLink, let url = URL(string: buyLink) else {
            return
        }
        
        let safari = SFSafariViewController(url: url)
        self.navigationController?.present(safari, animated: true, completion: nil)
    }
}
