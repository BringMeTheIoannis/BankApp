//
//  ViewController.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 17.01.23.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var cityCollection: UICollectionView!
    @IBOutlet weak var typeCollection: UICollectionView!
    @IBOutlet weak var citiesSpinner: UIActivityIndicatorView!
    
    var arrayOfATMS = [Models]()
    var filteredArrayOfATMS = [Models]()
    var arrayOfDepartments = [Models]()
    var filteredArrayOfDepartments = [Models]()
    var cities = [String]()
    var selectedCityIndexPath = IndexPath(item: 0, section: 0)
    var selectedTypeIndexPath = IndexPath(item: 0, section: 0)
    var selectedType: TypeOfDepartment = .atm
    var selectedCity: String = ""
    var typesOfDeps = TypeOfDepartment.allCases
    var isLoadingDeps: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        cityCollection.dataSource = self
        cityCollection.delegate = self
        typeCollection.dataSource = self
        typeCollection.delegate = self


        registerCells()
        initMap()
        getATMS()
        getDepartments()
        typeCollection.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    private func registerCells() {
        let nib = UINib(nibName: CityCollectionViewCell.id, bundle: nil)
        cityCollection.register(nib, forCellWithReuseIdentifier: CityCollectionViewCell.id)
        typeCollection.register(nib, forCellWithReuseIdentifier: CityCollectionViewCell.id)
    }
    
    func initMap() {
        let camera = GMSCameraPosition(latitude: 53.53, longitude: 27.34, zoom: 5)
        mapView.camera = camera
    }
    
    func getATMS() {
        citiesSpinner.startAnimating()
        Provider().getATM { [weak self] atms in
            guard let self = self else { return }
            self.arrayOfATMS = atms
            self.filteredArrayOfATMS = atms
            self.makeUniqueCitiesArray(array: atms)
//            self.filteredArrayOfATMS.forEach { atm in
//                self.drawMarker(lat: atm.gps_x, lon: atm.gps_y, color: .yellow)
//            }
            self.drawMarkers(selectedType: self.selectedType, selectedCity: self.selectedCity)
            self.citiesSpinner.stopAnimating()
            self.cityCollection.reloadData()
        } failure: {
            print("Failure: GetATMS")
            self.citiesSpinner.stopAnimating()
        }
    }
    
    func getDepartments() {
        isLoadingDeps = true
        typeCollection.reloadData()
        Provider().getDepartments { [weak self] departments in
            guard let self = self else { return }
            self.arrayOfDepartments = departments
            self.filteredArrayOfDepartments = departments
            self.makeUniqueCitiesArray(array: departments)
//            departments.forEach { dep in
//                self.drawMarker(lat: dep.gps_x, lon: dep.gps_y, color: .red)
//            }
            self.isLoadingDeps = false
            self.typeCollection.reloadData()
        } failure: {
            print("Failure")
            self.isLoadingDeps = false
            self.typeCollection.reloadData()
        }
    }
    
    func makeUniqueCitiesArray(array: [ATMModel]) {
        let _ = array.filter { atmCity in
            if cities.contains(atmCity.city) {
                return false
            } else {
                cities.append(atmCity.city)
                return true
            }
        }
        guard let firstCity = cities.first else { return }
        selectedCity = firstCity
    }
    
    func makeUniqueCitiesArray(array: [DepartmentModel]) {
        let _ = array.filter { depCity in
            if cities.contains(depCity.city) {
                return false
            } else {
                cities.append(depCity.city)
                return true
            }
        }
    }
    
    func drawMarker(lat: String, lon: String, color: UIColor) {
        guard let intLon = Double(lon), let intLat = Double(lat) else { return }
        let position = CLLocationCoordinate2D(latitude: intLat, longitude: intLon)
        let marker = GMSMarker(position: position)
        marker.icon = GMSMarker.markerImage(with: color)
        marker.map = self.mapView
    }
    
    func filterAndDraw(selectedCity: String, array: [Models], filteredArray: inout [Models], colorOfPin: UIColor) {
        filteredArray = array.filter{ $0.city == selectedCity }
        filteredArray.forEach { atmFilt in
            drawMarker(lat: atmFilt.lat, lon: atmFilt.lon, color: colorOfPin)
        }
    }
    
    func drawMarkers(selectedType: TypeOfDepartment, selectedCity: String) {
        mapView.clear()
        switch selectedType {
        case .atm:
            filterAndDraw(selectedCity: selectedCity, array: arrayOfATMS, filteredArray: &filteredArrayOfATMS, colorOfPin: .green)
        case .dep:
            filterAndDraw(selectedCity: selectedCity, array: arrayOfDepartments, filteredArray: &filteredArrayOfDepartments, colorOfPin: .systemYellow)
        case .all:
            filterAndDraw(selectedCity: selectedCity, array: arrayOfATMS, filteredArray: &filteredArrayOfATMS, colorOfPin: .green)
            filterAndDraw(selectedCity: selectedCity, array: arrayOfDepartments, filteredArray: &filteredArrayOfDepartments, colorOfPin: .systemYellow)
        }
    }
}

extension MapViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cityCollection {
            return cities.count
        }
        if collectionView == typeCollection {
            return typesOfDeps.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.id, for: indexPath)
        if collectionView == cityCollection {
            guard let cell = cell as? CityCollectionViewCell else { return cell }
            cell.isSelected = selectedCityIndexPath == indexPath
            cell.setup()
            cell.label.text = cities[indexPath.row]
            return cell
        }
        if collectionView == typeCollection {
            guard let cell = cell as? CityCollectionViewCell else { return cell}
            cell.isSelected = selectedTypeIndexPath == indexPath
            cell.setup()
            cell.label.text = typesOfDeps[indexPath.row].rawValue
            if isLoadingDeps, typesOfDeps[indexPath.row] != .atm  {
                cell.label.text = ""
                cell.spinner.startAnimating()
            }
            return cell
        }
        return cell
    }
}

extension MapViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cityCollection {
            selectedCityIndexPath = indexPath
            selectedCity = cities[indexPath.row]
            drawMarkers(selectedType: selectedType, selectedCity: selectedCity)
            cityCollection.reloadData()
        }
        if collectionView == typeCollection {
            if isLoadingDeps {
                return
            }
            selectedTypeIndexPath = indexPath
            selectedType = typesOfDeps[indexPath.row]
            drawMarkers(selectedType: selectedType, selectedCity: selectedCity)
            typeCollection.reloadData()
        }
    }
}

extension MapViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == typeCollection {
            let inset = 5.0
            guard let screen = view.window?.windowScene?.screen else { return .zero}
            let cellCount = Double(typesOfDeps.count)
            let width = (screen.bounds.width - (inset * (cellCount + 3))) / cellCount
            return CGSize(width: width, height: 47.0)
        }
        if collectionView == cityCollection {
            return CGSize(width: 171, height: 47)
        }
        return CGSize()
    }
}
