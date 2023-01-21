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
        Provider().getDrallInfo {[weak self] drall in
            guard let self = self else { return }
            self.drallArray = drall
            self.tableView.reloadData()
        } failure: {
            print("Error of getting drail info")
        }
    }
    
    private func addTargetForSegmentedControl() {
        segmentControl.addTarget(self, action: #selector(changeSelectedDrailType(target:)), for: .valueChanged)
    }
    
    @objc private func changeSelectedDrailType(target: UISegmentedControl) {
        selectedDrailType = drailTypes[target.selectedSegmentIndex]
        tableView.reloadData()
    }
}


extension DrallInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drallArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DrallCell.id, for: indexPath)
        guard let cell = cell as? DrallCell else { return cell }
        switch selectedDrailType {
        case .gold:
            cell.costLabel10.text = drallArray[indexPath.row].zol10Cost
            cell.costLabel20.text = drallArray[indexPath.row].zol20Cost
            cell.costLabel50.text = drallArray[indexPath.row].zol50Cost
        case .silver:
            cell.costLabel10.text = drallArray[indexPath.row].sil10Cost
            cell.costLabel20.text = drallArray[indexPath.row].sil20Cost
            cell.costLabel50.text = drallArray[indexPath.row].sil50Cost
        case .platinum:
            cell.costLabel10.text = drallArray[indexPath.row].pl10Cost
            cell.costLabel20.text = drallArray[indexPath.row].pl20Cost
            cell.costLabel50.text = drallArray[indexPath.row].pl50Cost
        }
        return cell
    }
}

extension DrallInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
