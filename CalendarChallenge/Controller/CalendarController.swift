//
//  ViewController.swift
//  CalendarChallenge
//
//  Created by k_motoyama on 2017/03/15.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit
import STV_Extensions


final class CalendarController: UIViewController {


    @IBOutlet weak var calendarCollectionView: UICollectionView!

    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    let cellMargin: CGFloat = 2.0
    var dataSource: UICollectionViewDataSource?
    var currentDate = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispInit(dispDate: currentDate)
        setDelegate()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        calendarCollectionView.reloadData()
    }

    @IBAction func clickBackButton(_ sender: Any) {
        
        currentDate = currentDate.preMonth()
        dispInit(dispDate: currentDate)
        
    }

    @IBAction func clickNextButton(_ sender: Any) {
        
        currentDate = currentDate.nextMonth()
        dispInit(dispDate: currentDate)
        
    }
    
    private func dispInit(dispDate: Date){
        let format = "yyyy年M月"
        
        navigationTitle.title = currentDate.toStr(dateFormat: format)
        dataSource = CalendarCollectionViewDataSource(date: dispDate)
        setDataSource()
    }
    
    private func setDataSource() {
        calendarCollectionView.dataSource = dataSource
    }
    
    private func setDelegate() {
        calendarCollectionView.delegate = self
    }

}

//MARK:-UICollectionViewDelegate
extension CalendarController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let dailySchedule =  UIStoryboard.viewController(storyboardName: "DailySchedule", identifier: "DailySchedule") as! DailyScheduleController
        
        let calendarCellData = CalendarCellData(currentDate: currentDate)
        let dispDate = calendarCellData.getCellDate(cellCount: calendarCellData.getCellCount(daysPerWeek: 7))[indexPath.row]
        
        dailySchedule.currentDate = dispDate
        
        let backButton = UIBarButtonItem()
        backButton.title = "戻る"
        
        self.navigationItem.backBarButtonItem = backButton
        
        self.navigationController?.pushViewController(dailySchedule, animated: true)
    }
}

//MARK:-UICollectionViewDelegateFlowLayout
extension CalendarController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfMargin: CGFloat = 8.0
        
        let cellWidth: CGFloat = (collectionView.frame.size.width - cellMargin * numberOfMargin) / CGFloat(7)
        
        let cellHeight: CGFloat = cellWidth * 1.0
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return cellMargin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return cellMargin
    }

    
}
