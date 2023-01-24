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
        setTableView()
        registerCells()
        getData()
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerCells() {
        let nib = UINib(nibName: NewsCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NewsCell.id)
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

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.id, for: indexPath)
        guard let cell = cell as? NewsCell else { return cell }
        cell.set(imageURL: newsArray[indexPath.row].imageURL)
        cell.label.text = newsArray[indexPath.row].title
        return cell
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
