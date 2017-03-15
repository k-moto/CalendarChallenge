//
//  DailyDisplayDataTest.swift
//  CalendarChallenge
//
//  Created by k_motoyama on 2017/03/15.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import XCTest
@testable import CalendarChallenge

class DailyDisplayDataTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testGetTodayModels(){
        
        let models = [ScheduleModel(),ScheduleModel(),ScheduleModel()]
        let format = "yyyy/MM/dd HH:mm"
        
        
        models[0].startTime = "2017/03/15 00:00".toDate(dateFormat: format)
        models[1].startTime = "2017/03/15 23:30".toDate(dateFormat: format)
        models[2].startTime = "2017/03/16 00:00".toDate(dateFormat: format)
        
        let result = DailyDisplayData().getTodayModels(models: models, today: "2017/03/15 00:00".toDate(dateFormat: format))
        
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].startTime!.toStr(dateFormat: format), "2017/03/15 00:00")
        XCTAssertEqual(result[1].startTime!.toStr(dateFormat: format), "2017/03/15 23:30")
    }
    
    func testGetDispTitleCheckStart(){
        
        let models = [ScheduleModel(),ScheduleModel(),ScheduleModel(),ScheduleModel()]
        let format = "yyyy/MM/dd HH:mm"
        
        let dispDate = "2017/03/15 16:30".toDate(dateFormat: format)
        
        models[0].startTime = "2017/03/15 00:00".toDate(dateFormat: format)
        models[0].endTime = "2017/03/15 10:00".toDate(dateFormat: format)
        models[0].title = "0時から10時のタイトル"
   
        models[1].startTime = "2017/03/15 11:00".toDate(dateFormat: format)
        models[1].endTime = "2017/03/15 16:00".toDate(dateFormat: format)
        models[1].title = "11時から16時のタイトル"
        
        models[2].startTime = "2017/03/15 16:30".toDate(dateFormat: format)
        models[2].endTime = "2017/03/15 20:00".toDate(dateFormat: format)
        models[2].title = "16時半から20時のタイトル"

        models[3].startTime = "2017/03/15 20:30".toDate(dateFormat: format)
        models[3].endTime = "2017/03/15 23:30".toDate(dateFormat: format)
        models[3].title = "20時半から23時半のタイトル"

        
        let dispTitle = DailyDisplayData().getDispTitle(models: models, dispDate: dispDate)
        
        XCTAssertEqual(dispTitle, "16時半から20時のタイトル")

    }
    
    func testGetDispTitleCheckMiddle(){
        
        let models = [ScheduleModel(),ScheduleModel(),ScheduleModel(),ScheduleModel(),ScheduleModel()]
        let format = "yyyy/MM/dd HH:mm"
        
        let dispDate = "2017/03/15 16:30".toDate(dateFormat: format)
        
        models[0].startTime = "2017/03/14 00:00".toDate(dateFormat: format)
        models[0].endTime = "2017/03/14 20:00".toDate(dateFormat: format)
        models[0].title = "14日の0時から20時のタイトル"
        
        models[1].startTime = "2017/03/15 11:30".toDate(dateFormat: format)
        models[1].endTime = "2017/03/15 13:30".toDate(dateFormat: format)
        models[1].title = "11時半から13時半のタイトル"
        
        models[2].startTime = "2017/03/15 14:00".toDate(dateFormat: format)
        models[2].endTime = "2017/03/15 18:00".toDate(dateFormat: format)
        models[2].title = "14時から18時のタイトル"
        
        models[3].startTime = "2017/03/15 19:00".toDate(dateFormat: format)
        models[3].endTime = "2017/03/15 20:30".toDate(dateFormat: format)
        models[3].title = "19時から20時半のタイトル"
        
        models[4].startTime = "2017/03/15 22:00".toDate(dateFormat: format)
        models[4].endTime = "2017/03/15 23:30".toDate(dateFormat: format)
        models[4].title = "22時から23時半のタイトル"
        
        let dispTitle = DailyDisplayData().getDispTitle(models: models, dispDate: dispDate)
        
        XCTAssertEqual(dispTitle, "14時から18時のタイトル")
        
    }
    
    func testGetDispTitleCheckEnd(){
        
        let models = [ScheduleModel(),ScheduleModel(),ScheduleModel()]
        let format = "yyyy/MM/dd HH:mm"
        
        let dispDate = "2017/03/15 16:30".toDate(dateFormat: format)
        
        models[0].startTime = "2017/03/15 00:00".toDate(dateFormat: format)
        models[0].endTime = "2017/03/15 10:00".toDate(dateFormat: format)
        models[0].title = "0時から10時のタイトル"
        
        models[1].startTime = "2017/03/15 12:30".toDate(dateFormat: format)
        models[1].endTime = "2017/03/15 16:30".toDate(dateFormat: format)
        models[1].title = "12時半から16時半のタイトル"
        
        models[2].startTime = "2017/03/15 17:00".toDate(dateFormat: format)
        models[2].endTime = "2017/03/15 23:30".toDate(dateFormat: format)
        models[2].title = "17時から23時半のタイトル"
        
        
        let dispTitle = DailyDisplayData().getDispTitle(models: models, dispDate: dispDate)
        
        XCTAssertEqual(dispTitle, "12時半から16時半のタイトル")
        
    }
    
}
