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
    var selectedCity = IndexPath()

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var cityCollection: UICollectionView!
    @IBOutlet weak var typeCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityCollection.dataSource = self
        cityCollection.delegate = self
        registerCells()
        initMap()
        getATMS()
        getDepartments()
    }
    
    func registerCells() {
        let nib = UINib(nibName: CityCollectionViewCell.id, bundle: nil)
        cityCollection.register(nib, forCellWithReuseIdentifier: CityCollectionViewCell.id)
    }
    
    func initMap() {
        let camera = GMSCameraPosition(latitude: 53.53, longitude: 27.34, zoom: 5)
        mapView.camera = camera
    }
    
    func getATMS() {
        Provider().getATM { [weak self] atms in
            guard let self = self else { return }
            self.arrayOfATMS = atms
            self.makeUniqueCitiesArray(array: atms)
            atms.forEach { atm in
                self.drawMarker(lat: atm.gps_x, lon: atm.gps_y, color: .yellow)
            }
            self.cityCollection.reloadData()
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
    
    func makeUniqueCitiesArray(array: [ATMModel]) {
        let _ = array.filter { city in
            if cities.contains(city.city) {
                return false
            } else {
                cities.append(city.city)
                return true
            }
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

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.id, for: indexPath)
        guard let cell = cell as? CityCollectionViewCell else { return cell }
        cell.isSelected = selectedCity == indexPath
        cell.setup()
        cell.label.text = cities[indexPath.row]
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCity = indexPath
        collectionView.reloadData()
    }
}
