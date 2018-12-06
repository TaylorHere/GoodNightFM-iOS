//
//  IndexCradCellCollectionViewCell.swift
//  GoodNightFM
//
//  Created by 李彦宏 on 2018/12/6.
//  Copyright © 2018 李彦宏. All rights reserved.
//

import UIKit

class CradCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         setCardShape()
    }

}

// Helpers
extension CradCell {
    
    func setCardShape() {
        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor(named: "dark")?.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
}

