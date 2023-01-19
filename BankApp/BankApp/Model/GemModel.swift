//
//  GemModel.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 19.01.23.
//

import Foundation
import ObjectMapper
 
class GemModel: Mappable {
    
    var number: String = ""
    var shape: String = ""
    var grani: String = ""
    var weight: String = ""
    var color: String = ""
    var cost: String = ""
    var city: String = ""
    var depNumber: String = ""
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        number <- map["attestat"]
        shape  <- map["name_ru"]
        grani  <- map["grani"]
        weight <- map["weight"]
        color  <- map["color"]
        cost   <- map["cost"]
        city   <- map["filial_id"]
    }
}
