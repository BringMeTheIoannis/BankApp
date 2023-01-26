//
//  RealmManager.swift
//  BankApp
//
//  Created by Ivan Kuzmenkov on 26.01.23.
//

import Foundation
import RealmSwift

class RealmManager<T> where T: Object {
    var realm = try! Realm()
    
    func write(object: T) {
        try? realm.write {
            realm.add(object)
        }
    }
    
    func read() -> Results<T> {
        return realm.objects(T.self)
    }
}
