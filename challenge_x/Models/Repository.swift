//
//  File.swift
//  challenge_x
//
//  Created by Diego Curumaco on 28/06/21.
//

import Foundation

struct Repository {
    
    enum RepositoryError {
        case nilValue
        
        var domain: String {
            return "repository"
        }
        
        var code: Int {
            switch self {
            case .nilValue:
                return 1
            }
        }
        
        var userInfo: [String: Any] {
            let messageKey = "message"
            switch self {
            case .nilValue:
                return [messageKey: "Nil value received for books array"]
            }
        }
        
        var error: NSError {
            switch self {
            case .nilValue:
                return NSError(domain: domain, code: code, userInfo: userInfo)
            }
        }
    }
    
    static func getBooks(completionBlock: @escaping (_ books: [Book]?, _ error: NSError?) -> Void) {
        API.books { dictionaries, apiError in
            if let error = apiError {
                completionBlock(nil, error)
                return
            }
            guard let booksArray = dictionaries else {
                completionBlock(nil, RepositoryError.nilValue.error)
                return
            }
            var books = [Book]()
            for bookDictionary in booksArray {
                books.append(Book(dictionary: bookDictionary))
            }
            completionBlock(books, nil)
        }
    }
}
