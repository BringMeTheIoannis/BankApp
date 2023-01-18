//
//  DepartmentModel.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 17.01.23.
//

import Foundation
import ObjectMapper


class DepartmentModel: Mappable {
    
    
    var department: String = ""
    var city: String = ""
    var gps_x: String = ""
    var gps_y: String = ""
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        department <- map["filial_name"]
        city       <- map["name"]
        gps_x      <- map["GPS_X"]
        gps_y      <- map["GPS_Y"]
    }
}
