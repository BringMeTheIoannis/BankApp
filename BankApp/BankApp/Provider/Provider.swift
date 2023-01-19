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
                guard let atm = try? response.mapArray(ATMModel.self)
                else {
                    failure?()
                    return
                }
                sucess(atm)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func getDepartments(success: @escaping ([DepartmentModel]) -> Void, failure: (()->Void)?) {
        provider.request(.departments) { result in
            switch result {
            case .success(let response):
                guard let departments = try? response.mapArray(DepartmentModel.self) else { failure?()
                    return
                }
                success(departments)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func getGems(success: @escaping ([GemModel]) -> Void, failure: (() -> Void)?) {
        provider.request(.gems) { result in
            switch result {
            case .success(let response):
                guard let gems = try? response.mapArray(GemModel.self) else { failure?()
                    return
                }
                success(gems)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
