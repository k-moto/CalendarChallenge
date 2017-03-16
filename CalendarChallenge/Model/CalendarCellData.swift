//
//  CalendarCellData.swift
//  CalendarChallenge
//
//  Created by k_motoyama on 2017/03/15.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import STV_Extensions

class CalendarCellData{
    
    let date: Date
    
    init(currentDate: Date){
        date = currentDate
    }
    
    func getCellCount(daysPerWeek: Int) -> Int {
        
        let calendar = Calendar(identifier: .gregorian)
        
        let rangeOfWeeks = calendar.range(of: .weekOfMonth, in: .month, for: date.startOfMonth()!)
        
        if let weekCount = rangeOfWeeks?.count{
            return weekCount * daysPerWeek
        } else {
            return 0
        }
        
    }
    
    func getCellDate(cellCount: Int) -> [Date]{
        
        let firstDate = date.startOfMonth()!
        
        var arrDispDate = [Date]()
        
        let calendar = Calendar(identifier: .gregorian)
        let ordinality = calendar.ordinality(of: .day, in: .weekOfMonth, for: firstDate) ?? 0
        
        
        for i in 0 ..< cellCount {
            var dateComponents = DateComponents()
            dateComponents.day = i - (ordinality - 1)

            arrDispDate.append(calendar.date(byAdding: dateComponents, to: firstDate)!)
        }
        
        return arrDispDate
        
    }
    
    
    
    
}
