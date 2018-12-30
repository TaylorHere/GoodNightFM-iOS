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
    var cell : CradCell
    public let CustomAnimatorTag = 99
    var elementsPatterns: [UIView: UIView] = [:]
    var trasitionElementsPatterns: [UIView: CGRect] = [:]
    var offsetHeight : CGFloat = 40
    
    init(duration : TimeInterval, isPresenting : Bool, originFrame : CGRect, cell : CradCell) {
        self.duration = duration
        self.isPresenting = isPresenting
        self.originFrame = originFrame
        self.cell = cell
    }
    
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let container = transitionContext.containerView
//
//        guard let fromViewController = transitionContext.viewController(forKey: .from) else {return}
//        guard let toViewController = transitionContext.viewController(forKey: .to) else {return}
//
//        guard let fromView = transitionContext.view(forKey: .from) else { return }
//        guard let toView = transitionContext.view(forKey: .to) else { return }
//
//        self.isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
//
//        let detailViewContoller: DetailViewController = (isPresenting ? toViewController : fromViewController) as! DetailViewController
//        self.offsetHeight = (detailViewContoller.navigationController?.navigationBar.frame.origin.y)! + (detailViewContoller.navigationController?.navigationBar.frame.height)!
//        let detailView = isPresenting ? toView : fromView
//
//        let detailViewCover = detailViewContoller.cover
//        let detailViewTitle = detailViewContoller._title
//        let detailViewSubitle = detailViewContoller.subtitle
//        let detailViewControlButton = detailViewContoller.controllButton
//
//        detailViewCover?.image = cell.cover.image
//        detailViewCover?.alpha = 0
//        detailViewTitle?.alpha = 0
//        detailViewSubitle?.alpha = 0
//        detailViewControlButton?.alpha = 0
//
//
//
//        let originToViewFrame = toView.frame
//        toView.frame = isPresenting ? self.originFrame : toView.frame
//        toView.alpha = isPresenting ? 0 : 1
//        toView.layoutIfNeeded()
////
//        if self.isPresenting {
//            cell.alpha = 0
//            let transitionImageView = UIImageView(frame: convertFrameToOriginFrame(frame: cell.cover.frame))
//            let transitionTitleView = UILabel(frame: convertFrameToOriginFrame(frame: cell.title.frame))
//            let transitionSubtitleView = UILabel(frame: convertFrameToOriginFrame(frame: cell.subtitle.frame))
//            let transitionControlButtonView = UIImageView(frame: convertFrameToOriginFrame(frame: cell.controlButton.frame))
//
//            transitionImageView.image = cell.cover.image
//            transitionTitleView.text = cell.title.text
//            transitionSubtitleView.text = cell.subtitle.text
//            transitionControlButtonView.image = cell.controlButton.image
//
//            container.addSubview(transitionImageView)
//            container.addSubview(transitionTitleView)
//            container.addSubview(transitionSubtitleView)
//            container.addSubview(transitionControlButtonView)
//
//            UIView.animate(withDuration: duration, animations: {
//                toView.frame = originToViewFrame
//                toView.alpha = 1
//                transitionImageView.frame = self.convertFrameByOffset(frame: detailViewCover!.frame)
//                transitionTitleView.frame = self.convertFrameByOffset(frame:detailViewTitle!.frame)
//                transitionSubtitleView.frame = self.convertFrameByOffset(frame:detailViewSubitle!.frame)
//                transitionControlButtonView.frame = self.convertFrameByOffset(frame:detailViewControlButton!.frame)
//
//            }, completion: { (finished) in
//                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//                transitionImageView.removeFromSuperview()
//                transitionImageView.removeFromSuperview()
//                transitionTitleView.removeFromSuperview()
//                transitionSubtitleView.removeFromSuperview()
//                transitionControlButtonView.removeFromSuperview()
//                detailViewCover?.alpha = 1
//                detailViewTitle?.alpha = 1
//                detailViewSubitle?.alpha = 1
//                detailViewControlButton?.alpha = 1
//            })
//        } else {
//            let transitionImageView = UIImageView(frame: self.convertFrameByOffset(frame: detailViewCover!.frame))
//            let transitionTitleView = UILabel(frame: self.convertFrameByOffset(frame:detailViewTitle!.frame))
//            let transitionSubtitleView = UILabel(frame: self.convertFrameByOffset(frame:detailViewSubitle!.frame))
//            let transitionControlButtonView = UIImageView(frame: self.convertFrameByOffset(frame:detailViewControlButton!.frame))
//
//            transitionImageView.image = cell.cover.image
//            transitionTitleView.text = cell.title.text
//            transitionSubtitleView.text = cell.subtitle.text
//            transitionControlButtonView.image = cell.controlButton.image
//
//            container.addSubview(transitionImageView)
//            container.addSubview(transitionTitleView)
//            container.addSubview(transitionSubtitleView)
//            container.addSubview(transitionControlButtonView)
//
//            UIView.animate(withDuration: duration, animations: {
//                transitionImageView.frame =  self.convertFrameToOriginFrame(frame: self.cell.cover.frame)
//                transitionTitleView.frame =  self.convertFrameToOriginFrame(frame: self.cell.title.frame)
//                transitionSubtitleView.frame =  self.convertFrameToOriginFrame(frame: self.cell.subtitle.frame)
//                transitionControlButtonView.frame = self.convertFrameToOriginFrame(frame: self.cell.controlButton.frame)
//                detailView.frame = self.originFrame
//                detailView.alpha =  0
//            }, completion: { (finished) in
//                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//                transitionImageView.removeFromSuperview()
//                transitionImageView.removeFromSuperview()
//                transitionTitleView.removeFromSuperview()
//                transitionSubtitleView.removeFromSuperview()
//                transitionControlButtonView.removeFromSuperview()
//                detailViewCover?.alpha = 1
//                detailViewTitle?.alpha = 1
//                detailViewSubitle?.alpha = 1
//                detailViewControlButton?.alpha = 1
//                self.cell.alpha = 1
//            })
//        }
//
//    }
    
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

    func flattenElements(aView: UIView, bView: UIView) -> ([UIView], [UIView]) {
        var aElements: [UIView] = []
        var bElements: [UIView] = []

        if !aElements.contains(aView) {
            aElements.append(aView)
        }
        if !bElements.contains(bView) {
            bElements.append(bView)
        }
        for aSubview in aView.subviews {
            for bSubview in bView.subviews {
                let (aSubElements, bSubElements) = flattenElements(aView: aSubview, bView: bSubview)
                aElements.append(contentsOf: aSubElements)
                bElements.append(contentsOf: bSubElements)
            }
        }
        return (aElements, bElements)
    }
    
    func findElements(aView: UIView, bView: UIView) {
        let (aElements, bElements) = self.flattenElements(aView: aView, bView: bView)
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
            let trasitionElement = aView.copyView()
            if isPresenting {
                trasitionElement!.frame = convertFrameToOriginFrame(frame: aView.frame)
                let toFrame = convertFrameByOffset(frame: bView.frame)
                self.trasitionElementsPatterns.updateValue(toFrame, forKey: trasitionElement!)
            }else{
                trasitionElement!.frame = convertFrameToOriginFrame(frame: bView.frame)
                let toFrame = convertFrameByOffset(frame: aView.frame)
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
        toView.alpha = isPresenting ? 0 : 1
        toView.layoutIfNeeded()
        
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        fromView.frame = isPresenting ? toView.frame : self.originFrame
        fromView.alpha = isPresenting ? 1 : 0
        fromView.layoutIfNeeded()

        
        UIView.animate(withDuration: duration, animations: {
            for (trasitionElement, toFrame) in self.trasitionElementsPatterns {
                trasitionElement.frame = toFrame
            }
            toView.frame = originToViewFrame
            toView.alpha = self.isPresenting ? 1 : 0
        }, completion: { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            for trasitionElement in self.trasitionElementsPatterns.keys {
                trasitionElement.removeFromSuperview()
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



