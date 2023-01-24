//
//  NewsViewController.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 23.01.23.
//

import UIKit

class NewsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var newsArray = [NewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    private func getData() {
        spinner.startAnimating()
        Provider().getNews {[weak self] news in
            guard let self = self else { return }
            self.newsArray = news
            self.tableView.reloadData()
            self.spinner.stopAnimating()
        } failure: {
            print("Failure to get news")
            self.spinner.stopAnimating()
        }
    }
}
