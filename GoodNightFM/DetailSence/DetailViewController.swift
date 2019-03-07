//
//  DetailViewController.swift
//  GoodNightFM
//
//  Created by 李彦宏 on 2018/12/7.
//  Copyright © 2018 李彦宏. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var controllButton: UIImageView!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var _title: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setZpotions()
    }


}

extension DetailViewController {
    
    func setZpotions() {
        self.cover.layer.zPosition = 0
        self.subtitle.layer.zPosition = 1
        self._title.layer.zPosition = 2
        self.controllButton.layer.zPosition = 3
    }
    
}


