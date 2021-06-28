//
//  Book.swift
//  challenge_x
//
//  Created by Diego Curumaco on 28/06/21.
//

import Foundation

struct Book {
    let title: String
    let imageUrl: String
    let author: String
    
    init(title: String, imageUrl: String, author: String) {
        self.title = title
        self.imageUrl = imageUrl
        self.author = author
    }
    
    init(dictionary: [String: Any]) {
        if let title = dictionary["title"] as? String {
            self.title = title
        } else {
            self.title = ""
        }
        
        if let imageUrl = dictionary["imageURL"] as? String {
            self.imageUrl = imageUrl
        } else {
            self.imageUrl = ""
        }
        
        if let author = dictionary["author"] as? String {
            self.author = author
        } else {
            self.author = ""
        }
    }
}
