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
    
    func isOneDaySchedule(models: [ScheduleModel], dispDate: Date) -> Bool {
        
        let thisMonthModels = models.filter{ isThisMonthData(baseDate: $0.startTime, comparisonDate: date) }

        var result = false
        
        let format = "yyyy/MM/dd"
        
        for model in thisMonthModels{
            
            if model.startTime?.toStr(dateFormat: format) == dispDate.toStr(dateFormat: format) {
                result = true
                break
            }
            
        }
        
        return result
    }
    
    private func isThisMonthData(baseDate: Date?, comparisonDate: Date) -> Bool{
        let calendar = Calendar(identifier: .gregorian)
        
        var result = false
        
        if let baseDate = baseDate {
            result = calendar.compare(baseDate, to: comparisonDate, toGranularity: .month) == .orderedSame

        }
        
        return result
    }
    
}
