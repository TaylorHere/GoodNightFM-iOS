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
        let view = self.snapshotView(afterScreenUpdates: false)
        view?.layer.zPosition = self.layer.zPosition
        return view as? T
    }
}
