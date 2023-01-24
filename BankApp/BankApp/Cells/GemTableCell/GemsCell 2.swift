//
//  GemsCell.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 19.01.23.
//

import UIKit

class GemsCell: UITableViewCell {
    static let id = String(describing: GemsCell.self)
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameGraniWeight: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var cost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
