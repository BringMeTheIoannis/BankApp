//
//  DrallInfoViewController.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 21.01.23.
//

import UIKit

class DrallInfoViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var drallArray = [DrallModel]()
    var filteredDrallArray = [DrallModel]()
    var selectedDrailType: TypeOfDrails = .gold
    var drailTypes: [TypeOfDrails] = TypeOfDrails.allCases
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        addTargetForSegmentedControl()
        tableviewProtocols()
        registerCells()
    }
    
    private func registerCells() {
        let nib = UINib(nibName: DrallCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: DrallCell.id)
    }
    
    private func tableviewProtocols() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getData() {
        spinner.startAnimating()
        Provider().getDrallInfo {[weak self] drall in
            guard let self = self else { return }
            self.drallArray = drall
            self.filterArray(selectedDrailType: self.selectedDrailType)
            self.tableView.reloadData()
            self.spinner.stopAnimating()
        } failure: {
            print("Error of getting drail info")
            self.spinner.stopAnimating()
        }
    }
    
    private func addTargetForSegmentedControl() {
        segmentControl.addTarget(self, action: #selector(changeSelectedDrailType(target:)), for: .valueChanged)
    }
    
    @objc private func changeSelectedDrailType(target: UISegmentedControl) {
        selectedDrailType = drailTypes[target.selectedSegmentIndex]
        filteredDrallArray = filteredDrallArray.compactMap{$0 }
        filterArray(selectedDrailType: selectedDrailType)
        tableView.reloadData()
    }
    
    private func filterArray(selectedDrailType: TypeOfDrails) {
        switch selectedDrailType {
        case .gold:
            filteredDrallArray = drallArray.filter{
                Double($0.zol10Cost) ?? 0.00 > 0.00  ||
                Double($0.zol20Cost) ?? 0.00 > 0.00 ||
                Double($0.zol50Cost) ?? 0.00 > 0.00
            }
        case .silver:
            filteredDrallArray = drallArray.filter{
                Double($0.sil10Cost) ?? 0.00 > 0.00  ||
                Double($0.sil20Cost) ?? 0.00 > 0.00 ||
                Double($0.sil50Cost) ?? 0.00 > 0.00
            }
        case .platinum:
            filteredDrallArray = drallArray.filter{
                Double($0.pl10Cost) ?? 0.00 > 0.00  ||
                Double($0.pl20Cost) ?? 0.00 > 0.00 ||
                Double($0.pl50Cost) ?? 0.00 > 0.00
            }
        }
    }
    
    private func textForCell(cost: String) -> String {
        Double(cost) ?? 0.00 == 0.00 ? "Out of stock" : "\(cost) BYN"
    }
}


extension DrallInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDrallArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DrallCell.id, for: indexPath)
        guard let cell = cell as? DrallCell else { return cell }
        cell.cityLabel.text = "City: \(filteredDrallArray[indexPath.row].city)"
        cell.departmentLabel.text = "Filial: \(filteredDrallArray[indexPath.row].filialName)"
        switch selectedDrailType {
        case .gold:
            cell.costLabel10.text = "10g.: \(textForCell(cost: filteredDrallArray[indexPath.row].zol10Cost))"
            cell.costLabel20.text = "20g.: \(textForCell(cost: filteredDrallArray[indexPath.row].zol20Cost))"
            cell.costLabel50.text = "50g.: \(textForCell(cost: filteredDrallArray[indexPath.row].zol50Cost))"
        case .silver:
            cell.costLabel10.text = "10g.: \(textForCell(cost: filteredDrallArray[indexPath.row].sil10Cost))"
            cell.costLabel20.text = "20g.: \(textForCell(cost: filteredDrallArray[indexPath.row].sil10Cost))"
            cell.costLabel50.text = "50g.: \(textForCell(cost: filteredDrallArray[indexPath.row].sil10Cost))"
        case .platinum:
            cell.costLabel10.text = "10g.: \(textForCell(cost: filteredDrallArray[indexPath.row].pl10Cost))"
            cell.costLabel20.text = "20g.: \(textForCell(cost: filteredDrallArray[indexPath.row].pl10Cost))"
            cell.costLabel50.text = "50g.: \(textForCell(cost: filteredDrallArray[indexPath.row].pl10Cost))"
        }
        return cell
    }
}

extension DrallInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
