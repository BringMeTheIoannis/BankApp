//
//  CityCollectionViewCell.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 18.01.23.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        self.container.layer.cornerRadius = 15
        self.container.layer.borderWidth = 1.0
        self.container.layer.borderColor = UIColor.black.cgColor
    }
}
