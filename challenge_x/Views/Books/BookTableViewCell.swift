//
//  BookTableViewCell.swift
//  challenge_x
//
//  Created by Diego Curumaco on 28/06/21.
//

import UIKit
import Kingfisher

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var imgBook: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    
    var book: Book? = nil {
        didSet {
            if let book = book {
                self.updateBookInformation(book)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func updateBookInformation(_ book: Book) {
        lblTitle.text = book.title
        lblAuthor.text = book.author
        guard book.imageUrl != "" else {
            return
        }
        guard let validUrl = URL(string: book.imageUrl) else {
            return
        }
        
        imgBook.kf.setImage(
            with: validUrl,
            placeholder: UIImage(systemName: "photo")
        )
    }
}
