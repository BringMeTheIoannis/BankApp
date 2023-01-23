//
//  API.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 17.01.23.
//

import Foundation
import Moya


enum Requests {
    case atm
    case departments
    case gems
    case drall
}

extension Requests: TargetType {
    var baseURL: URL {
            return URL(string: "https://belarusbank.by/api/")!
    }
    
    var path: String {
        switch self {
        case .atm:
            return "atm"
        case .departments:
            return "filials_info"
        case .gems:
            return "getgems"
        case .drall:
            return "getinfodrall"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .atm, .departments, .gems, .drall:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .atm:
            return .requestPlain
        case .departments:
            return .requestPlain
        case .gems:
            return .requestPlain
        case .drall:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

