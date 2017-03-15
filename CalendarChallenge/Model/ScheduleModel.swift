//
//  ScheduleModel.swift
//  CalendarChallenge
//
//  Created by k_motoyama on 2017/03/15.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import RealmSwift

class ScheduleModel: Object {
    dynamic var taskID = 0
    dynamic var title = ""
    dynamic var place = ""
    dynamic var startTime: Date?
    dynamic var endTime: Date?
    dynamic var details = ""
    
    override static func primaryKey() -> String? {
        return "taskID"
    }
}
