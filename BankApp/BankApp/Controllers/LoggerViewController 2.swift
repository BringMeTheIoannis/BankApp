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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromDB()
    }
    
    private func getDataFromDB() {
        let data = realm.read()
        loggedData = Array(data)
        tableView.reloadData()
    }
    
}
