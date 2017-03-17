//
//  ScheduleController.swift
//  CalendarChallenge
//
//  Created by k_motoyama on 2017/03/17.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit
import STV_Extensions

enum labelTag: Int{
    case titleLabel = 0
    case placeLabel = 1
    case endTimeLabel = 2
    case detailTextView = 3
}

final class ScheduleController: UITableViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var placeField: UITextField!
    
    var currentDate: Date?
    var isLoad: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "予定"
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(ScheduleController.onClickSaveButton))
        saveButton.title = "保存"
        
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(ScheduleController.onClickDeleteButton))
        
        self.navigationItem.rightBarButtonItems = [saveButton,deleteButton]

        let format = "yyyy/M/d H:mm"
        
        startTimeLabel.text = currentDate!.toStr(dateFormat: format) + "〜"
        
        isLoad = -1
        saveDataInit()
        
    }
    
    @IBAction func editTextField(_ sender: UITextField) {
        
        let calendar = Calendar(identifier: .gregorian)
        let datePickerView:UIDatePicker = UIDatePicker()
        
        
        let startHour = Int(currentDate!.toStr(dateFormat: "HH"))!
        let startMinute = Int(currentDate!.toStr(dateFormat: "mm"))!

        datePickerView.minimumDate = calendar.date(bySettingHour: startHour, minute: startMinute, second: 0, of:currentDate!)!
        datePickerView.maximumDate = calendar.date(bySettingHour: 23, minute: 30, second: 0, of: currentDate!)!
        
        datePickerView.datePickerMode = UIDatePickerMode.time
        datePickerView.minuteInterval = 30

        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(ScheduleController.datePickerValueChanged), for: .valueChanged)
        
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        let format = "yyyy/M/d H:mm"
        endTimeField.text = "〜" + sender.date.toStr(dateFormat: format)
        
    }
    
    func saveDataInit(){
        
        let models = ScheduleDao.findAll()
        
        if models.count == 0 {
            return
        }
        
        let result = isCheckSchedule(models: models)
        
        if result == -1 {
            return
        }
        
        let format = "yyyy/M/d H:mm"
        
        titleTextField.text = models[result].title
        placeField.text = models[result].place
        startTimeLabel.text = models[result].startTime!.toStr(dateFormat: format) + "〜"
        endTimeField.text = models[result].endTime!.toStr(dateFormat: format) + "〜"
        detailTextView.text = models[result].details
     
        
        isLoad = models[result].taskID
    }
    
    func onClickSaveButton(sender: UIBarButtonItem){
        let object = ScheduleModel()
        
        let format = "yyyy/MM/dd HH:mm"

        if isLoad != -1 {
            object.taskID = ScheduleDao.findByID(taskID: isLoad!)!.taskID
        }

        object.title = titleTextField.text!
        object.place = placeField.text!
        
        let startTimeText = startTimeLabel.text!.replacingOccurrences(of: "〜", with: "")
        
        object.startTime = startTimeText.toDate(dateFormat: format)
        
        if !endTimeField.text!.isEmpty {
            
            let endTimeText = endTimeField.text!.replacingOccurrences(of: "〜", with: "")

            object.endTime = endTimeText.toDate(dateFormat: format)
        }
        
        object.details = detailTextView.text
        
        let scheduleValidator = ScheduleValidator.init(currentModel: object)
        scheduleValidator.validationCheck()
        
        switch scheduleValidator.result! {
        case ValidationCheckResult.notBoth:
            showAlert(dispText: "タイトル・終了時間を入力してください")
        case ValidationCheckResult.notTitle:
            showAlert(dispText: "タイトルを入力してください")
        case ValidationCheckResult.notEndTime:
            showAlert(dispText: "終了時間を入力してください")
        case ValidationCheckResult.normal:
            
            if isLoad != -1 {
                ScheduleDao.update(model: object)
            } else {
                ScheduleDao.add(model:object)
            }
            
        }
        
        _ = navigationController?.popViewController(animated: true)

    }
    
    func onClickDeleteButton(sender: UIBarButtonItem){
        showDeleteAlert()
    }
    
    func deleteData(){
        
        let modelDatas = ScheduleDao.findAll()
        
        let result = isCheckSchedule(models: modelDatas)
        
        if result == -1 {
            return
        }
        
        ScheduleDao.delete(taskID: modelDatas[result].taskID)
        
        _ = navigationController?.popViewController(animated: true)

    }
    
    func isCheckSchedule(models: [ScheduleModel]) -> Int{
        
        let calendar = Calendar(identifier: .gregorian)

        var result = -1
        var count = 0
        
        for model in models {
            let startResult = calendar.compare(currentDate!, to: model.startTime!, toGranularity: .minute) != .orderedAscending
            
            let endResult = calendar.compare(currentDate!, to: model.endTime!, toGranularity: .minute) != .orderedDescending
            
            if startResult && endResult {
                result = count
                break
            }
            count += 1
            
        }
        

        return result
    }
    
    func showAlert(dispText: String){
        let alert = UIAlertController(
            title: "警告",
            message: dispText,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showDeleteAlert(){
        let alert = UIAlertController(
            title: "警告",
            message: "この予定を削除しますか？",
            preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ (action:UIAlertAction!) -> Void in self.deleteData() }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        // アラート表示
        self.present(alert, animated: true, completion: nil)
    }
    
}
