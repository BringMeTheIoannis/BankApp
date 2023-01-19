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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .atm:
            return .get
        case .departments:
            return .get
        case .gems:
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
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

