//
//  CalendarCellDataTest.swift
//  CalendarChallenge
//
//  Created by k_motoyama on 2017/03/17.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import XCTest
@testable import CalendarChallenge

class CalendarCellDataTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSetCellCount(){
        
        let format = "yyyy/MM/dd HH:mm"
        let currentDate = "2017/03/15 00:00".toDate(dateFormat: format)
        
        let cellCount = CalendarCellData(currentDate: currentDate).getCellCount(daysPerWeek: 7)
        
        XCTAssertEqual(cellCount, 35)
        
    }
    
    func testGetCellData(){
        
        let format = "yyyy/MM/dd"
        let currentDate = "2017/03/15".toDate(dateFormat: format)
        
        let arrData = CalendarCellData(currentDate: currentDate).getCellDate(cellCount: 35)
        
        XCTAssertEqual(arrData[0].toStr(dateFormat: format), "2017/02/26")

    }
    
    func testIsOneDayScheduleNotget(){
        
        let format = "yyyy/MM/dd"
        let currentDate = "2017/03/15".toDate(dateFormat: format)
        
        let models = [ScheduleModel(),ScheduleModel(),ScheduleModel(),ScheduleModel()]
        
        models[0].startTime = "2017/03/15".toDate(dateFormat: format)
        models[1].startTime = "2017/03/16".toDate(dateFormat: format)
        models[2].startTime = "2017/03/19".toDate(dateFormat: format)
        models[3].startTime = "2017/03/20".toDate(dateFormat: format)
        
        
        let dispDate = "2017/03/21".toDate(dateFormat: format)

        
        let isSchedule = CalendarCellData(currentDate: currentDate).isOneDaySchedule(models: models, dispDate: dispDate)
        
        XCTAssertFalse(isSchedule)
        
    }
 
    
    func testIsOneDayScheduleGet(){
        
        let format = "yyyy/MM/dd"
        let currentDate = "2017/03/15".toDate(dateFormat: format)
        
        let models = [ScheduleModel(),ScheduleModel(),ScheduleModel(),ScheduleModel()]
        
        models[0].startTime = "2017/03/15".toDate(dateFormat: format)
        models[1].startTime = "2017/03/16".toDate(dateFormat: format)
        models[2].startTime = "2017/03/19".toDate(dateFormat: format)
        models[3].startTime = "2017/03/20".toDate(dateFormat: format)
        
        
        let dispDate = "2017/03/19".toDate(dateFormat: format)
        
        
        let isSchedule = CalendarCellData(currentDate: currentDate).isOneDaySchedule(models: models, dispDate: dispDate)
        
        XCTAssertTrue(isSchedule)
        
    }
    
}
