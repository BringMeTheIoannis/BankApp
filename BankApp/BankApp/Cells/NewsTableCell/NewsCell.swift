//
//  NewsCell.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 23.01.23.
//

import UIKit

class NewsCell: UITableViewCell {
    static var id = String(describing: NewsCell.self)
    
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
