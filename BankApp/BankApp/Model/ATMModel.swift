//
//  ATMModel.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 17.01.23.
//

import Foundation
import ObjectMapper

class ATMModel: Mappable {
    var area: String = ""
    var work_time: String = ""
    var gps_x: String = ""
    var gps_y: String = ""
    var cash_in: String = ""
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        area        <- map["area"]
        work_time   <- map["work_time"]
        gps_x       <- map["gps_x"]
        gps_y       <- map["gps_y"]
        cash_in     <- map["cash_in"]
    }
}
