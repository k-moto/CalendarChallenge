//
//  CalendarCollectionViewDataSource.swift
//  CalendarChallenge
//
//  Created by k_motoyama on 2017/03/17.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit
import STV_Extensions

final class CalendarCollectionViewDataSource:NSObject, UICollectionViewDataSource {
    
    let weekNameData = ["日","月","火","水","木","金","土"]
    let calendarCellData: CalendarCellData
    
    init(date: Date){
        calendarCellData = CalendarCellData(currentDate: date)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return weekNameData.count
            
        } else {
            return calendarCellData.getCellCount(daysPerWeek: weekNameData.count)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as! CalendarCollectionViewCell
        
        if indexPath.section == 0 {
            
            cell.cellText.text = weekNameData[indexPath.row]
            cell.cellText.textColor = setColor(dispWeekDay: weekNameData[indexPath.row])

        } else {
            let dispDate = calendarCellData.getCellDate(cellCount: calendarCellData.getCellCount(daysPerWeek: weekNameData.count))[indexPath.row]
            
            let format = "d"
            
            cell.cellText.text =  dispDate.toStr(dateFormat: format)
            if !calendarCellData.isThisMonthData(comparisonDate: dispDate) {
                cell.cellText.textColor = UIColor.gray
            } else {
                cell.cellText.textColor = setColor(dispWeekDay: dispDate.shortWeekdayStr())
            }
            cell.cellText.isHidden = isCheckSchedule(date: dispDate)
        }
        
        return cell
    }
    
    private func isCheckSchedule(date: Date) -> Bool{
     
        return calendarCellData.isOneDaySchedule(models: ScheduleDao.findAll(), dispDate: date)
    }
    
    private func setColor(dispWeekDay: String) -> UIColor{
        
        switch dispWeekDay {
        case "日":
            return UIColor.red
            
        case "土":
            return UIColor.blue
            
        default:
            return UIColor.black
            
        }
        
    }
}
