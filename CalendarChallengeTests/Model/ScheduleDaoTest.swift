//
//  ScheduleDaoTest.swift
//  CalendarChallenge
//
//  Created by k_motoyama on 2017/03/15.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import XCTest
@testable import CalendarChallenge

class ScheduleDaoTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
        ScheduleDao.deleteAll()
    }
    
    func testAdd(){
        let object = ScheduleModel()
        
        let startTime = "2016/01/01 10:00"
        let endTime = "2016/01/01 18:30"
        let format = "yyyy/MM/dd HH:mm"
        
        object.taskID = 1
        object.title = "テストタイトル1"
        object.place = "東京"
        object.startTime = startTime.toDate(dateFormat: format)
        object.endTime = endTime.toDate(dateFormat: format)
        object.details = "詳細"
        
        ScheduleDao.add(model:object)
        
        verifyItem(taskID: 1, title: "テストタイトル1", place: "東京", startTimeStr: startTime, endTimeStr: endTime, details: "詳細")
    }
    
    func testUpdate(){
        
        let object = ScheduleModel()

        let startTime = "2016/01/01 10:00"
        let endTime = "2016/01/01 18:30"
        let format = "yyyy/MM/dd HH:mm"
        
        object.taskID = 1
        object.title = "テストタイトル1"
        object.place = "東京"
        object.startTime = startTime.toDate(dateFormat: format)
        object.endTime = endTime.toDate(dateFormat: format)
        object.details = "詳細"
        
        ScheduleDao.add(model:object)
        
        object.taskID = 1
        object.title = "テストタイトル2"
        object.place = "名古屋"
        object.details = "詳細_追加"
        object.endTime = "2016/01/01 20:30".toDate(dateFormat: format)
        
        ScheduleDao.update(model:object)
        
        verifyItem(taskID: 1, title: "テストタイトル2", place: "名古屋", startTimeStr: startTime, endTimeStr: "2016/01/01 20:30", details: "詳細　追加")
    }
    
    func testDelete(){
        
        let object = ScheduleModel()
        
        let startTime = "2016/01/01 10:00"
        let endTime = "2016/01/01 18:30"
        let format = "yyyy/MM/dd HH:mm"
        
        object.taskID = 1
        object.title = "テストタイトル1"
        object.place = "東京"
        object.startTime = startTime.toDate(dateFormat: format)
        object.endTime = endTime.toDate(dateFormat: format)
        object.details = "詳細"
        
        ScheduleDao.add(model:object)
        
        ScheduleDao.delete(taskID: 1)
        
        verifyCount(count:0)
    }
    
    func testFindByID(){

        let object = ScheduleModel()
        
        let startTime = "2016/01/01 10:00"
        let endTime = "2016/01/01 18:30"
        let format = "yyyy/MM/dd HH:mm"
        
        object.taskID = 1
        object.title = "テストタイトル1"
        object.place = "東京"
        object.startTime = startTime.toDate(dateFormat: format)
        object.endTime = endTime.toDate(dateFormat: format)
        object.details = "詳細"
        
        ScheduleDao.add(model:object)
        
        let result = ScheduleDao.findByID(taskID: 1)
        
        XCTAssertEqual(result?.taskID, 1)
    }
    
    func testFindAll(){

        let tasks = [ScheduleModel(),ScheduleModel(),ScheduleModel()]
        
        _ = tasks.map {
            ScheduleDao.add(model:$0)
        }
        
        verifyCount(count:3)
    }
    
    //MARK:-private method
    private func verifyItem(taskID: Int, title: String, place: String, startTimeStr: String, endTimeStr: String, details: String) {
        
        let format = "yyyy/MM/dd HH:mm"
        
        let result = ScheduleDao.findAll()
        
        XCTAssertEqual(result.first?.taskID, taskID)
        
        XCTAssertEqual(result.first?.title, title)
        
        if let place = result.first?.place {
            XCTAssertEqual(place, place)
        }
        
        XCTAssertEqual(result.first?.startTime?.toStr(dateFormat: format), startTimeStr)
        
        XCTAssertEqual(result.first?.endTime?.toStr(dateFormat: format), endTimeStr)
        

        if let details = result.first?.details {
            XCTAssertEqual(details, details)
        }
    }
    
    private func verifyCount(count: Int) {
        
        let result = ScheduleDao.findAll()
        XCTAssertEqual(result.count, count)
    }
}
    
