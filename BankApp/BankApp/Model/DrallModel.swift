//
//  DrallModel.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 19.01.23.
//

import Foundation
import ObjectMapper

class DrallModel: Mappable {
    var city: String = ""
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
    }
}