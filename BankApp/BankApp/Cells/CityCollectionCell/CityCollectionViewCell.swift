//
//  CityCollectionViewCell.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 18.01.23.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {
    static let id = String(describing: CityCollectionViewCell.self)

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        self.container.layer.cornerRadius = 15
        self.container.layer.borderWidth = 1.0
        self.container.layer.borderColor = UIColor.black.cgColor
        self.container.layer.backgroundColor = self.isSelected ? UIColor.black.cgColor : UIColor.white.cgColor
        self.label.textColor = self.isSelected ? UIColor.white : UIColor.black
    }
}
