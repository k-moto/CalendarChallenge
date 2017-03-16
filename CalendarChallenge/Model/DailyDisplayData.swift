//
//  DailyDisplayData.swift
//  CalendarChallenge
//
//  Created by k_motoyama on 2017/03/15.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import STV_Extensions

class DailyDisplayData{
    
    func getDispTime(dispDate: Date , cellID: Int) -> Date{
        
        let calendar = Calendar(identifier: .gregorian)
        
        let hour = Int(floor(Double(cellID / 2)))
        let minute = cellID % 2 == 0 ? 0 : 30
        
        return calendar.date(bySettingHour: hour, minute: minute, second: 0, of: dispDate)!
        
    }
    
    func getTodayModels(models: [ScheduleModel], today: Date) -> [ScheduleModel] {
        
        return models.filter{ isTodayData(baseDate: $0.startTime, comparisonDate: today) }
    }
    
    func getDispTitle(models: [ScheduleModel], dispDate: Date) -> String{
        
        let calendar = Calendar(identifier: .gregorian)
        var scheduleTitle = ""
        
        for model in models {
            let startResult = calendar.compare(dispDate, to: model.startTime!, toGranularity: .minute) != .orderedAscending
            
            let endResult = calendar.compare(dispDate, to: model.endTime!, toGranularity: .minute) != .orderedDescending

            if startResult && endResult {
                scheduleTitle = model.title
                
                break
            }
            
        }
        
        return scheduleTitle
    }
    
    private func isTodayData(baseDate: Date?, comparisonDate: Date) -> Bool{
        let calendar = Calendar(identifier: .gregorian)
        
        var result = false
        
        if let baseDate = baseDate {
           result = calendar.compare(baseDate, to: comparisonDate, toGranularity: .day) == .orderedSame
        }
        
        return result
    }
    
    
}
