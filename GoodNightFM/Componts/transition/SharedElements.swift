/*
 * Copyright (c) 2019 李彦宏
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

// this transitioning works like Shared Elements in Android.
// it will transition the elements between two sence if the elements own the same tag.

import UIKit

class SharedElements : NSObject, UIViewControllerAnimatedTransitioning {
    var duration : TimeInterval
    var isPresenting : Bool
    var originFrame : CGRect
    var cell : UICollectionViewCell
    public let CustomAnimatorTag = 99
    var elementsPatterns: [UIView: UIView] = [:]
    var trasitionElementsPatterns: [UIView: CGRect] = [:]
    var offsetHeight : CGFloat = 40
    
    init(duration : TimeInterval, isPresenting : Bool, originFrame : CGRect, cell : UICollectionViewCell) {
        self.duration = duration
        self.isPresenting = isPresenting
        self.originFrame = originFrame
        self.cell = cell
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView

        guard let fromViewController = transitionContext.viewController(forKey: .from) else {return}
        guard let toViewController = transitionContext.viewController(forKey: .to) else {return}

        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }

        self.isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)

        self.offsetHeight = (toViewController.navigationController?.navigationBar.frame.origin.y)! + (toViewController.navigationController?.navigationBar.frame.height)!
        
        var aView: UIView? = nil
        var bView: UIView? = nil

        if self.cell != nil{
            aView = self.cell
        }else{
            aView = isPresenting ? fromView : toView
        }

        bView = isPresenting ? toView : fromView

        self.findElements(aView: aView!, bView: bView!)
        let transitionElements = self.createTransitionView()
        for transitionElement in transitionElements{
            container.addSubview(transitionElement)
        }
        self.animationFrame(transitionContext: transitionContext)
    }
}



// animation flows
extension SharedElements {

    func flattenElements(treeView: UIView) -> [UIView] {
        var Elements: [UIView] = []
        

        if !Elements.contains(treeView) {
            Elements.append(treeView)
        }
    
        for subview in treeView.subviews {
            let subElements = flattenElements(treeView: subview)
            Elements.append(contentsOf: subElements)
        }
        return Elements
    }
    
    func findElements(aView: UIView, bView: UIView) {
        let aElements = self.flattenElements(treeView: aView)
        let bElements = self.flattenElements(treeView: bView)
        for aElement in aElements{
            for bElement in bElements{
                if aElement != bElement{
                    if aElement.tag != 0 || bElement.tag != 0 {
                        if aElement.tag == bElement.tag {
                            self.elementsPatterns.updateValue(bElement, forKey: aElement)
                        }
                    }
                }
            }
        }
    }
    
    func createTransitionView() -> [UIView] {
        var transitionElements: [UIView] = []
        for (aView, bView) in self.elementsPatterns {
            let trasitionElement = isPresenting ? aView.copyView() : bView.copyView()
            aView.alpha = 0
            bView.alpha = 0
            if isPresenting {
                trasitionElement!.frame = convertFrameToOriginFrame(frame: aView.frame)
                let toFrame = convertFrameByOffset(frame: bView.frame)
                self.trasitionElementsPatterns.updateValue(toFrame, forKey: trasitionElement!)
            }else{
                trasitionElement!.frame = convertFrameByOffset(frame: bView.frame)
                let toFrame = convertFrameToOriginFrame(frame: aView.frame)
                self.trasitionElementsPatterns.updateValue(toFrame, forKey: trasitionElement!)
            }
            transitionElements.append(trasitionElement!)
        }
        return transitionElements
    }
    
    func animationFrame(transitionContext:UIViewControllerContextTransitioning ) {

        guard let toView = transitionContext.view(forKey: .to) else { return }
        let originToViewFrame = toView.frame
        toView.frame = isPresenting ? self.originFrame : toView.frame
        toView.alpha = 0
        toView.layoutIfNeeded()

        guard let fromView = transitionContext.view(forKey: .from) else { return }
        fromView.frame = isPresenting ? toView.frame : fromView.frame
        fromView.alpha = 1
        fromView.layoutIfNeeded()

        
        UIView.animate(withDuration: duration, animations: {
            for (trasitionElement, toFrame) in self.trasitionElementsPatterns {
                trasitionElement.frame = toFrame
            }
            toView.frame = originToViewFrame
            toView.alpha = 1
            fromView.alpha = 0
        }, completion: { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            for trasitionElement in self.trasitionElementsPatterns.keys {
                trasitionElement.removeFromSuperview()
            }
            for (aView, bView) in self.elementsPatterns {
                aView.alpha = 1
                bView.alpha = 1
            }
        })
        
        
    }
}

// helpers.
extension SharedElements {
    
    func convertFrameToOriginFrame(frame: CGRect) -> CGRect {
        let newFrame = CGRect(x: self.originFrame.origin.x + frame.origin.x, y: self.originFrame.origin.y + frame.origin.y, width: frame.width, height: frame.height)
        return newFrame
    }
    
    func convertFrameByOffset(frame: CGRect) -> CGRect {
        let newFrame = CGRect(x: frame.origin.x, y: frame.origin.y + offsetHeight, width: frame.width, height: frame.height)
        return newFrame
    }
}



