//
//  ScheduleModelTest.swift
//  CalendarChallenge
//
//  Created by k_motoyama on 2017/03/15.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import XCTest
import STV_Extensions
@testable import CalendarChallenge

class ScheduleModelTest: XCTestCase {
    
    let item = ScheduleModel()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testScheduleModelDefault(){
        
        XCTAssertEqual(item.taskID, 0)
        XCTAssertEqual(item.title, "")
        XCTAssertEqual(item.place, "")
        XCTAssertNil(item.startTime)
        XCTAssertNil(item.endTime)
        XCTAssertEqual(item.details, "")
        
    }
    
    func testScheduleModel(){
        
        let startTime = "2016/01/01 10:00"
        let endTime = "2016/01/01 18:30"
        let format = "yyyy/MM/dd HH:mm"
        
        item.taskID = 1
        item.title = "テストタイトル1"
        item.place = "東京"
        item.startTime = startTime.toDate(dateFormat: format)
        item.endTime = endTime.toDate(dateFormat: format)
        item.details = "詳細"
        
        XCTAssertEqual(item.taskID, 1)
        XCTAssertEqual(item.title, "テストタイトル1")
        XCTAssertEqual(item.place, "東京")
        XCTAssertEqual(item.startTime?.toStr(dateFormat: format),startTime)
        XCTAssertEqual(item.endTime?.toStr(dateFormat: format),endTime)
        XCTAssertEqual(item.details, "詳細")
        
    }
}
