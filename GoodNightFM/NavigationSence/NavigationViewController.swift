    
    //
//  NavigationViewController.swift
//  GoodNightFM
//
//  Created by 李彦宏 on 2018/12/11.
//  Copyright © 2018 李彦宏. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

}

// NavigationControllerDelegate to apply our Transition.
extension NavigationViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        var selectedFrame : CGRect? = nil
        var selectedCell : UICollectionViewCell? = nil
        var isPresenting = true
        var delegateVC: UIViewController? = nil
        
        switch operation {
        case .push:
            delegateVC = fromVC
            isPresenting = true
        case .pop:
            delegateVC = toVC
            isPresenting = false
        case .none:
            return ContextPopTransition()
        }

        selectedFrame = (delegateVC as? SharedElementViewController)?.selectedFrame
        selectedCell = (delegateVC as? SharedElementViewController)?.selectedCell

        if selectedCell != nil || selectedFrame != nil {
            return SharedElements(duration: 0.4, isPresenting: isPresenting, originFrame: selectedFrame, cell: selectedCell)
        }else{
            return ContextPopTransition()
        }
    }
}
