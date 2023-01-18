//
//  ViewController.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 17.01.23.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    var arrayOfATMS = [ATMModel]()
    var arrayOfDepartments = [DepartmentModel]()
    var cities = [String]()

    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMap()
        getATMS()
        getDepartments()
    }
    
    func initMap() {
        let camera = GMSCameraPosition(latitude: 53.53, longitude: 27.34, zoom: 5)
        mapView.camera = camera
    }
    
    func getATMS() {
        Provider().getATM { [weak self] atms in
            guard let self = self else { return }
            self.arrayOfATMS = atms
            atms.forEach { atm in
                self.drawMarker(lat: atm.gps_x, lon: atm.gps_y, color: .yellow)
            }
        } failure: {
            print("Failure: GetATMS")
        }
    }
    
    func getDepartments() {
        Provider().getDepartments { [weak self] departments in
            guard let self = self else { return }
            self.arrayOfDepartments = departments
            departments.forEach { dep in
                self.drawMarker(lat: dep.gps_x, lon: dep.gps_y, color: .red)
            }
        } failure: {
            print("Failure")
        }
    }
    
    func drawMarker(lat: String, lon: String, color: UIColor) {
        let intLon = Double(lon) ?? 0
        let intLat = Double(lat) ?? 0
        let position = CLLocationCoordinate2D(latitude: intLat, longitude: intLon)
        let marker = GMSMarker(position: position)
        marker.icon = GMSMarker.markerImage(with: color)
        marker.map = self.mapView
    }
    
}

