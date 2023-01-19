//
//  DepartmentModel.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 17.01.23.
//

import Foundation
import ObjectMapper


class DepartmentModel: Mappable, Models {
    
    
    var department: String = ""
    var city: String = ""
    var lat: String = ""
    var lon: String = ""
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        department <- map["filial_name"]
        city       <- map["name"]
        lat        <- map["GPS_X"]
        lon        <- map["GPS_Y"]
    }
}
