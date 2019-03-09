//
//  IndexCradCellCollectionViewCell.swift
//  GoodNightFM
//
//  Created by 李彦宏 on 2018/12/6.
//  Copyright © 2018 李彦宏. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var controlButton: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCardShape()
        setZpotions()
    }

}

// Helpers
extension CardCell {
    
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
    
    func setZpotions() {
        self.cover.layer.zPosition = 0
        self.subtitle.layer.zPosition = 1
        self.title.layer.zPosition = 2
        self.controlButton.layer.zPosition = 3
    }
    
}

