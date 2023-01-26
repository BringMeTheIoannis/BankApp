//
//  LoggerModel.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 26.01.23.
//

import Foundation
import RealmSwift
import Moya

class Logger: Object {
    @objc dynamic var requestName: String = ""
    @objc dynamic var requestTime: Date = Date()
    @objc dynamic var requestStatusCode: String = ""
    
    convenience init(requestName: RequestType, requestTime: Date, requestStatusCode: String) {
        self.init()
        self.requestName = requestName.rawValue
        self.requestTime = requestTime
        self.requestStatusCode = requestStatusCode
    }
}
