//
//  NewsModel.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 23.01.23.
//

import Foundation
import ObjectMapper

class NewsModel: Mappable {
    
    var title: String = ""
    var imageURL: String = ""
    var link: String = ""
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        title       <- map["name_ru"]
        imageURL   <- map["img"]
        link        <- map["link"]
    }
}
