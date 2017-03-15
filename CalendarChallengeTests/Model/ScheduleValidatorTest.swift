//
//  ScheduleValidatorTest.swift
//  CalendarChallenge
//
//  Created by k_motoyama on 2017/03/15.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import XCTest
@testable import CalendarChallenge

class ScheduleValidatorTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValidationCheckNormal(){
        
        let object = ScheduleModel()
        
        let endTime = "2016/01/01 18:30"
        let format = "yyyy/MM/dd HH:mm"
        
        object.title = "テストタイトル1"
        object.endTime = endTime.toDate(dateFormat: format)
        
        
        let scheduleValidator = ScheduleValidator.init(currentModel: object)
        scheduleValidator.validationCheck()
        
        XCTAssertEqual(scheduleValidator.result, ValidationCheckResult.normal)
    }
    
    func testValidationCheckNotBoth(){
        
        let object = ScheduleModel()
        
        let scheduleValidator = ScheduleValidator.init(currentModel: object)
        scheduleValidator.validationCheck()
        
        XCTAssertEqual(scheduleValidator.result, ValidationCheckResult.notBoth)
    }
    
    func testValidationCheckNotEndTime(){
        
        let object = ScheduleModel()
        
        object.title = "テストタイトル1"
        
        let scheduleValidator = ScheduleValidator.init(currentModel: object)
        scheduleValidator.validationCheck()
        
        XCTAssertEqual(scheduleValidator.result, ValidationCheckResult.notEndTime)
    }
    
    func testValidationCheckNotTitle(){
        
        let object = ScheduleModel()
        
        let endTime = "2016/01/01 18:30"
        let format = "yyyy/MM/dd HH:mm"
        
        object.endTime = endTime.toDate(dateFormat: format)
        
        
        let scheduleValidator = ScheduleValidator.init(currentModel: object)
        scheduleValidator.validationCheck()
        
        XCTAssertEqual(scheduleValidator.result, ValidationCheckResult.notTitle)
    }
    
}
