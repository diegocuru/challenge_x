//
//  ViewController.swift
//  challenge_x
//
//  Created by Diego Curumaco on 28/06/21.
//

import UIKit

class BooksViewController: UIViewController {

    @IBOutlet weak var tableViewBooks: UITableView!
    
    var books: [Book]?
    var alertControllerError: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadBooks()
    }
}

// MARK: Setup
extension BooksViewController {
    private func setupTableView() {
        tableViewBooks.dataSource = self
        tableViewBooks.delegate = self
        tableViewBooks.register(UINib(nibName: "BookTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BookTableViewCell")
    }
}

// MARK: Data
extension BooksViewController{
    private func loadBooks() {
        Repository.getBooks { [weak self] books, repositoryError in
            guard let books = books else {
                
                if let error = repositoryError {
                    self?.displayErrorMessage(error)
                }
                
                return
            }
            self?.books = books
            self?.tableViewBooks.reloadData()
        }
    }
    
    private func displayErrorMessage(_ error: NSError) {
        
        let errorMessage = error.userInfo["message"] as? String ?? "Some error occurred"
        alertControllerError = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        guard let alertController = alertControllerError else {
            return
        }
        let alertActionOk = UIAlertAction(title: "OK", style: .default) { _ in
            
        }
        alertController.addAction(alertActionOk)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: Table View Data Source
extension BooksViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let books = books else {
            return 0
        }
        return books.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell") as! BookTableViewCell
        if let books = books {
            cell.book = books[indexPath.row]
        }
        return cell
    }
}

// MARK: - Table View Delegate
extension BooksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
