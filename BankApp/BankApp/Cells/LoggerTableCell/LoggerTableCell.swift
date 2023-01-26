//
//  LoggerTableCell.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 26.01.23.
//

import UIKit

class LoggerTableCell: UITableViewCell {
    static var id = String(describing: LoggerTableCell.self)

    @IBOutlet weak var queryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusCodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
