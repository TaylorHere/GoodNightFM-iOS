//
//  Helpers.swift
//  GoodNightFM
//
//  Created by 李彦宏 on 2018/12/29.
//  Copyright © 2018 李彦宏. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    func copyView<T:UIView>() -> T? {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject:self, requiringSecureCoding:false)
            return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T
        } catch {
            print("err when copy views: \(error)")
        }
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.red.cgColor
        return view as? T
    }
}
