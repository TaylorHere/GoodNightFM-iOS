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

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}

// Screen width.
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}
