//
//  LoggerViewController.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 26.01.23.
//

import UIKit

class LoggerViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var realm = RealmManager<Logger>()
    var loggedData = [Logger]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromDB()
    }
    
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerCells() {
        let nib = UINib(nibName: LoggerTableCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: LoggerTableCell.id)
    }
    
    private func getDataFromDB() {
        let data = realm.read()
        loggedData = Array(data)
        loggedData.sort {
            $0.requestTime > $1.requestTime
        }
        tableView.reloadData()
    }
}

extension LoggerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension LoggerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loggedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LoggerTableCell.id, for: indexPath)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.mm.yyyy, HH:mm:ss"
        guard let cell = cell as? LoggerTableCell else { return cell}
        cell.queryLabel.text = "Request name: \(loggedData[indexPath.row].requestName)"
        cell.dateLabel.text = "DateTime: \(dateFormatter.string(from: loggedData[indexPath.row].requestTime))"
        cell.statusCodeLabel.text = "Status code: \(loggedData[indexPath.row].requestStatusCode)"
        return cell
    }
}

