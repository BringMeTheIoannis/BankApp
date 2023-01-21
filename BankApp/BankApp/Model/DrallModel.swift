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
    var filialName: String = ""
    var zol10Cost: String = ""
    var zol20Cost: String = ""
    var zol50Cost: String = ""
    var sil10Cost: String = ""
    var sil20Cost: String = ""
    var sil50Cost: String = ""
    var pl10Cost: String = ""
    var pl20Cost: String = ""
    var pl50Cost: String = ""
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        city        <- map["name"]
        filialName  <- map["filials_text"]
        zol10Cost   <- map["ZOL_10_out"]
        zol20Cost   <- map["ZOL_20_out"]
        zol50Cost   <- map["ZOL_50_out"]
        sil10Cost   <- map["SIL_10_out"]
        sil20Cost   <- map["SIL_20_out"]
        sil50Cost   <- map["SIL_50_out"]
        pl10Cost    <- map["PL_10_out"]
        pl20Cost    <- map["PL_20_out"]
        pl50Cost    <- map["PL_50_out"]
    }
}
