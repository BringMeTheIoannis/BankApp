//
//  ATMModel.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 17.01.23.
//

import Foundation
import ObjectMapper

class ATMModel: Mappable, Models {
    var area: String = ""
    var work_time: String = ""
    var lat: String = ""
    var lon: String = ""
    var cash_in: String = ""
    var city: String = ""
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        area        <- map["area"]
        work_time   <- map["work_time"]
        lat         <- map["gps_x"]
        lon         <- map["gps_y"]
        cash_in     <- map["cash_in"]
        city        <- map["city"]
    }
}
