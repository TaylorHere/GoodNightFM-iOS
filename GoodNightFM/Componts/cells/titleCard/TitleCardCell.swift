//
//  TitleCardCell.swift
//  GoodNightFM
//
//  Created by taylor on 2019/3/9.
//  Copyright © 2019 李彦宏. All rights reserved.
//

import UIKit

class TitleCardCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCardShape()
        setZPosition()
    }

}

extension TitleCardCell{
    
    func setCardShape() {
        self.image.layer.cornerRadius = 8.0
        self.image.layer.borderWidth = 1.0
        self.image.layer.borderColor = UIColor.clear.cgColor
        self.image.layer.masksToBounds = true
        self.layer.shadowColor = UIColor(named: "dark")?.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        //        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    func setZPosition() {
        self.image.layer.zPosition = 0
        self.title.layer.zPosition = 1
    }
}
