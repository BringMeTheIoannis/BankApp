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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .atm:
            return .get
        case .departments:
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
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

