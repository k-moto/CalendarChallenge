//
//  CalendarCellCountTest.swift
//  CalendarChallenge
//
//  Created by k_motoyama on 2017/03/17.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import XCTest
@testable import CalendarChallenge

class CalendarCellCountTest: XCTestCase {
    
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
    
    
}
