//
//  DailyScheduleTableViewDataSource.swift
//  CalendarChallenge
//
//  Created by k_motoyama on 2017/03/17.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit
import STV_Extensions

final class DailyScheduleTableViewDataSource:NSObject, UITableViewDataSource {

    let currentDate: Date
    
    init(date: Date){
       currentDate = date
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 48
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: DailyScheduleTableViewCell.identifier, for: indexPath) as! DailyScheduleTableViewCell
        
        let format = "H:mm"
        
        let dispTime = DailyDisplayData().getDispTime(dispDate: currentDate,cellID: indexPath.row)
        
        let dispTimeText = dispTime.toStr(dateFormat: format)

        
        cell.timeLabel.text = dispTimeText + "~"
        cell.timeLabel.textColor = UIColor.gray
        
        let dispScheduleText = DailyDisplayData().getDispTitle(models: ScheduleDao.findAll(), dispDate: dispTime)
        
        if !dispScheduleText.isEmpty {
            cell.scheduleLabel.text = dispScheduleText
            cell.backgroundColor = UIColor.init(hex: Int("DDEFFC", radix: 16)!)

        }
        
        return cell
    }
    
    
}
