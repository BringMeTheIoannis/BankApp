//
//  Provider.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 17.01.23.
//

import Foundation
import Moya
import Moya_ObjectMapper


class Provider {
    private let provider = MoyaProvider<Requests>(plugins: [NetworkLoggerPlugin()])
    
    func getATM(sucess: @escaping ([ATMModel]) -> Void, failure: (()->Void)?) {
        provider.request(.atm) { result in
            switch result {
            case .success(let response):
                guard let departments = try? response.mapArray(ATMModel.self)
                else {
                    failure?()
                    return
                }
                sucess(departments)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
