//
//  API.swift
//  challenge_x
//
//  Created by Diego Curumaco on 28/06/21.
//

import Foundation
import Alamofire

struct API {
    
    enum APIError {
        case request
        
        var domain: String {
            return "api"
        }
        
        var code: Int {
            switch self {
            case .request:
                return 1
            }
        }
        
        var userInfo: [String: Any] {
            let messageKey = "message"
            switch self {
            case .request:
                return [messageKey: "Error while requesting data"]
            }
        }
        
        var error: NSError {
            switch self {
            case .request:
                return NSError(domain: domain, code: code, userInfo: userInfo)
            }
        }
    }
    
    enum Endpoint {
        case books
        
        var url: String {
            switch self {
            case .books:
                return "http://de-coding-test.s3.amazonaws.com/books.json"
            }
        }
    }
    
    
    static func books(completionBlock: @escaping (_ books: [[String: Any]]?, _ error: NSError?) -> Void) {
        AF.request(Endpoint.books.url).responseJSON { dataResponse in
            guard let booksArray = dataResponse.value as? [[String: Any]] else {
                completionBlock(nil, APIError.request.error)
                return
            }
            completionBlock(booksArray, nil)
        }
    }
}
