//
//  RealmHelper.swift
//  CalendarChallenge
//
//  Created by k_motoyama on 2017/03/15.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmHelper <T : RealmSwift.Object>{
    
    let realm: Realm
    
    init(){
        try! realm = Realm()
    }
    
    func findAll() -> Results<T> {
        return realm.objects(T.self)
    }
    
    func findFirst(key: AnyObject) -> T? {
        return realm.object(ofType: T.self, forPrimaryKey: key)
    }
    
    func newId() -> Int? {
        guard let key = T.primaryKey() else {
            return nil
        }
        
        if let last = realm.objects(T.self).last as? RealmSwift.Object,
            let lastId = last[key] as? Int {
            return lastId + 1
        } else {
            return 1
        }
    }
    
    
    func add(d :T) {
        do {
            try realm.write {
                realm.add(d)
            }
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func update(d: T, block:(() -> Void)? = nil) -> Bool {
        do {
            try realm.write {
                block?()
                realm.add(d, update: true)
            }
            return true
        } catch let error as NSError {
            print(error.description)
        }
        return false
    }
    
    func delete(d: T) {
        do {
            try realm.write {
                realm.delete(d)
            }
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func deleteAll(){
        let objs = realm.objects(T.self)
        do {
            try realm.write {
                realm.delete(objs)
            }
        } catch let error as NSError {
            print(error.description)
        }
    }
}
