//
//  ViewController.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 17.01.23.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Provider().getATM { result in
            print("Результат \(result[0].work_time)")
        } failure: {
            print("failure")
        }
    }
}

