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
    case news
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
        case .news:
            return "news_info"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .atm, .departments, .gems, .drall, .news:
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
        case .news:
            guard let parameters = parameters else { return .requestPlain }
            return .requestParameters(parameters: parameters, encoding: encoding)
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .atm:
            return URLEncoding.queryString
        case .departments:
            return URLEncoding.queryString
        case .gems:
            return URLEncoding.queryString
        case .drall:
            return URLEncoding.queryString
        case .news:
            return URLEncoding.queryString
        }
    }
    
    var parameters: [String:Any]? {
        
        var params = [String:Any]()
        
        switch self {
        case .atm:
            return nil
        case .departments:
            return nil
        case .gems:
            return nil
        case .drall:
            return nil
        case .news:
            params["lang"] = "ru"
            return params
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

