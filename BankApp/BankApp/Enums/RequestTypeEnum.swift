//
//  RequestTypeEnum.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 26.01.23.
//

import Foundation
import RealmSwift

enum RequestType: String, PersistableEnum {
    case getDeps
    case getATMs
    case getGems
    case getDralls
    case getNews
}
