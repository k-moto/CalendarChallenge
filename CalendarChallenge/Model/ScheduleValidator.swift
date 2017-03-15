//
//  ScheduleValidator.swift
//  CalendarChallenge
//
//  Created by k_motoyama on 2017/03/15.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation

enum ValidationCheckResult {
    case notBoth
    case notTitle
    case notEndTime
    case normal
}


class ScheduleValidator{
    
    let model: ScheduleModel
    
    var result: ValidationCheckResult?
    
    init(currentModel: ScheduleModel){
        model = currentModel
    }
    
    func validationCheck(){
        
        if model.title.isEmpty && model.endTime == nil {
            result = .notBoth
        } else if model.title.isEmpty {
            result = .notTitle
        } else if model.endTime == nil {
            result = .notEndTime
        } else {
            result = .normal
        }
        
    }
    
}
