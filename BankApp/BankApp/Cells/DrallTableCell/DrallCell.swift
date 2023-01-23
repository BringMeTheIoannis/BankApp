//
//  DrallCell.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 21.01.23.
//

import UIKit

class DrallCell: UITableViewCell {
    static let id = String(describing: DrallCell.self)

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var costLabel10: UILabel!
    @IBOutlet weak var costLabel20: UILabel!
    @IBOutlet weak var costLabel50: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
