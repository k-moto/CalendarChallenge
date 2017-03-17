//
//  DailyScheduleController.swift
//  CalendarChallenge
//
//  Created by k_motoyama on 2017/03/17.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit
import STV_Extensions


final class DailyScheduleController: UIViewController {
    
    
    @IBOutlet weak var dailyScheduleTableView: UITableView!
    
    var dataSource: UITableViewDataSource?
    var currentDate: Date?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let format = "yyyy年M月d日 " + currentDate!.weekdayStr()

        self.navigationItem.title = currentDate?.toStr(dateFormat: format)
        dataSource = DailyScheduleTableViewDataSource(date: currentDate!)
        setDataSource()
        setDelegate()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        dailyScheduleTableView.reloadData()
    }
    
    private func setDataSource() {
        dailyScheduleTableView.dataSource = dataSource
    }
    
    private func setDelegate() {
        dailyScheduleTableView.delegate = self
    }

}


//MARK:-UICollectionViewDelegate
extension DailyScheduleController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let scheduleController =  UIStoryboard.viewController(storyboardName: "Schedule", identifier: "Schedule") as! ScheduleController
        scheduleController.currentDate = DailyDisplayData().getDispTime(dispDate: currentDate!,cellID: indexPath.row)
        
        let backButton = UIBarButtonItem()
        backButton.title = "戻る"
        
        self.navigationItem.backBarButtonItem = backButton
        
        self.navigationController?.pushViewController(scheduleController, animated: true)
    }
}


