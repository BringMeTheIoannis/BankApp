//
//  GemViewController.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 19.01.23.
//

import UIKit

class GemViewController: UIViewController {
    
    var gemsArray = [GemModel]()
    var isFilteredUp: Bool = false

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerCells()
        getGems()
    }
    
    func registerCells() {
        let nib = UINib(nibName: GemsCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: GemsCell.id)
    }
    
    func getGems() {
        spinner.startAnimating()
        Provider().getGems {[weak self] gems in
            guard let self = self else { return }
            self.gemsArray = gems
            self.tableView.reloadData()
            self.spinner.stopAnimating()
        } failure: {
            print("Failure of getting gems")
            self.spinner.stopAnimating()
        }
    }
    @IBAction func sortingButtonAction(_ sender: UIButton) {
        
        if isFilteredUp {
            sender.setTitle("Asc", for: .normal)
            gemsArray.sort {
                $0.cost > $1.cost
            }
        } else {
            sender.setTitle("Desc", for: .normal)
            gemsArray.sort {
                $0.cost < $1.cost
            }
        }
        isFilteredUp.toggle()
        tableView.reloadData()
    }
    
}

extension GemViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GemsCell.id, for: indexPath)
        guard let cell = cell as? GemsCell else { return cell}
        cell.numberLabel.text = "Number: \(gemsArray[indexPath.row].number)"
        cell.nameGraniWeight.text = "Shape: \(gemsArray[indexPath.row].shape) Grani: \(gemsArray[indexPath.row].grani) Weight: \(gemsArray[indexPath.row].weight)"
        cell.color.text = "Color: \(gemsArray[indexPath.row].color)"
        cell.cost.text = "Cost: \(gemsArray[indexPath.row].cost)"
        return cell
    }
}

extension GemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
