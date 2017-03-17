//
//  CalendarCollectionViewCell.swift
//  CalendarChallenge
//
//  Created by k_motoyama on 2017/03/17.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit

final class CalendarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellText: UILabel!
    @IBOutlet weak var circleLabel: UILabel!
    
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
    
}
