//
//  ScheduleDao.swift
//  CalendarChallenge
//
//  Created by k_motoyama on 2017/03/15.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import RealmSwift

final class ScheduleDao{
    
    static let dao = RealmHelper<ScheduleModel>()
    
    static func add(model: ScheduleModel){
        
        let object = ScheduleModel()
        object.taskID = ScheduleDao.dao.newId()!
        object.title = model.title
        object.place = model.place
        object.startTime = model.startTime
        object.endTime = model.endTime
        object.details = model.details
        ScheduleDao.dao.add(d: object)
    
    }
    
    static func update(model: ScheduleModel) {
        
        guard let object = dao.findFirst(key: model.taskID as AnyObject) else {
            return
        }
        
        _ = dao.update(d: object,block:{() -> Void in
            object.title = model.title
            object.place = model.place
            object.endTime = model.endTime
            object.details = model.details
        })
    }

    
    static func delete(taskID: Int) {
        
        guard let object = dao.findFirst(key: taskID as AnyObject) else {
            return
        }
        dao.delete(d: object)
    }
    
    static func deleteAll(){
        dao.deleteAll()
    }
    
    
    static func findByID(taskID: Int) -> ScheduleModel? {
        guard let object = dao.findFirst(key: taskID as AnyObject) else {
            return nil
        }
        return object
    }
    
    static func findAll() -> [ScheduleModel] {
        let objects =  ScheduleDao.dao.findAll()
        return objects.map { ScheduleModel(value: $0) }
    }

}
