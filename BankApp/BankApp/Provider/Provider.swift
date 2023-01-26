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
    private var realm = RealmManager<Logger>()
    
    private func writeToRealm(requestName: RequestType, requestStatusCode: String) {
        let logger = Logger(requestName: requestName, requestTime: Date(), requestStatusCode: requestStatusCode)
        self.realm.write(object: logger)
    }
    
    func getATM(sucess: @escaping ([ATMModel]) -> Void, failure: (()->Void)?) {
        provider.request(.atm) { result in
            switch result {
            case .success(let response):
                let statusCode = String(response.statusCode)
                self.writeToRealm(requestName: .getATMs, requestStatusCode: statusCode)
                guard let atm = try? response.mapArray(ATMModel.self)
                else {
                    self.writeToRealm(requestName: .getATMs, requestStatusCode: statusCode)
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
                let statusCode = String(response.statusCode)
                self.writeToRealm(requestName: .getDeps, requestStatusCode: statusCode)
                guard let departments = try? response.mapArray(DepartmentModel.self) else {
                    self.writeToRealm(requestName: .getDeps, requestStatusCode: statusCode)
                    failure?()
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
                let statusCode = String(response.statusCode)
                self.writeToRealm(requestName: .getGems, requestStatusCode: statusCode)
                guard let gems = try? response.mapArray(GemModel.self) else {
                    self.writeToRealm(requestName: .getGems, requestStatusCode: statusCode)
                    failure?()
                    return
                }
                success(gems)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getDrallInfo(success: @escaping ([DrallModel]) -> Void, failure: (() -> Void)?) {
        provider.request(.drall) { result in
            switch result {
            case .success(let response):
                let statusCode = String(response.statusCode)
                self.writeToRealm(requestName: .getDralls, requestStatusCode: statusCode)
                guard let drall = try? response.mapArray(DrallModel.self) else {
                    self.writeToRealm(requestName: .getDralls, requestStatusCode: statusCode)
                    failure?()
                    return}
                success(drall)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getNews(success: @escaping ([NewsModel]) -> Void, failure: (() -> Void)?) {
        provider.request(.news) { result in
            switch result {
            case .success(let response):
                let statusCode = String(response.statusCode)
                self.writeToRealm(requestName: .getNews, requestStatusCode: statusCode)
                guard let news = try? response.mapArray(NewsModel.self)
                else {
                    self.writeToRealm(requestName: .getNews, requestStatusCode: statusCode)
                    failure?()
                    return
                }
                success(news)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
