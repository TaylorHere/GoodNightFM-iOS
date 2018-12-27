import UIKit

class CoverTrasition : NSObject, UIViewControllerAnimatedTransitioning {
    var duration : TimeInterval
    var isPresenting : Bool
    var originFrame : CGRect
    var cell : CradCell
    public let CustomAnimatorTag = 99
    
    var offsetHeight : CGFloat = 40
    
    init(duration : TimeInterval, isPresenting : Bool, originFrame : CGRect, cell : CradCell) {
        self.duration = duration
        self.isPresenting = isPresenting
        self.originFrame = originFrame
        self.cell = cell
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let fromViewController = transitionContext.viewController(forKey: .from) else {return}
        guard let toViewController = transitionContext.viewController(forKey: .to) else {return}

        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }

        self.isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
        
        let detailViewContoller: DetailViewController = (isPresenting ? toViewController : fromViewController) as! DetailViewController
        self.offsetHeight = (detailViewContoller.navigationController?.navigationBar.frame.origin.y)! + (detailViewContoller.navigationController?.navigationBar.frame.height)!
        let detailView = isPresenting ? toView : fromView
        
        let detailViewCover = detailViewContoller.cover
        let detailViewTitle = detailViewContoller._title
        let detailViewSubitle = detailViewContoller.subtitle
        let detailViewControlButton = detailViewContoller.controllButton
        
        detailViewCover?.image = cell.cover.image
        detailViewCover?.alpha = 0
        detailViewTitle?.alpha = 0
        detailViewSubitle?.alpha = 0
        detailViewControlButton?.alpha = 0

        

        let originToViewFrame = toView.frame
        toView.frame = isPresenting ? self.originFrame : toView.frame
        toView.alpha = isPresenting ? 0 : 1
        toView.layoutIfNeeded()
//
        if self.isPresenting {
            let transitionImageView = UIImageView(frame: convertFrameToOriginFrame(frame: cell.cover.frame))
            let transitionTitleView = UILabel(frame: convertFrameToOriginFrame(frame: cell.title.frame))
            let transitionSubtitleView = UILabel(frame: convertFrameToOriginFrame(frame: cell.subtitle.frame))
            let transitionControlButtonView = UIImageView(frame: convertFrameToOriginFrame(frame: cell.controlButton.frame))
            
            transitionImageView.image = cell.cover.image
            transitionTitleView.text = cell.title.text
            transitionSubtitleView.text = cell.subtitle.text
            transitionControlButtonView.image = cell.controlButton.image
            
            container.addSubview(transitionImageView)
            container.addSubview(transitionTitleView)
            container.addSubview(transitionSubtitleView)
            container.addSubview(transitionControlButtonView)
            
            UIView.animate(withDuration: duration, animations: {
                toView.frame = originToViewFrame
                toView.alpha = 1
                transitionImageView.frame = self.convertFrameByOffset(frame: detailViewCover!.frame)
                transitionTitleView.frame = self.convertFrameByOffset(frame:detailViewTitle!.frame)
                transitionSubtitleView.frame = self.convertFrameByOffset(frame:detailViewSubitle!.frame)
                transitionControlButtonView.frame = self.convertFrameByOffset(frame:detailViewControlButton!.frame)
                
            }, completion: { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                transitionImageView.removeFromSuperview()
                transitionImageView.removeFromSuperview()
                transitionTitleView.removeFromSuperview()
                transitionSubtitleView.removeFromSuperview()
                transitionControlButtonView.removeFromSuperview()
                detailViewCover?.alpha = 1
                detailViewTitle?.alpha = 1
                detailViewSubitle?.alpha = 1
                detailViewControlButton?.alpha = 1
            })
        } else {
            let transitionImageView = UIImageView(frame: self.convertFrameByOffset(frame: detailViewCover!.frame))
            let transitionTitleView = UILabel(frame: self.convertFrameByOffset(frame:detailViewTitle!.frame))
            let transitionSubtitleView = UILabel(frame: self.convertFrameByOffset(frame:detailViewSubitle!.frame))
            let transitionControlButtonView = UIImageView(frame: self.convertFrameByOffset(frame:detailViewControlButton!.frame))
            
            transitionImageView.image = cell.cover.image
            transitionTitleView.text = cell.title.text
            transitionSubtitleView.text = cell.subtitle.text
            transitionControlButtonView.image = cell.controlButton.image
            
            container.addSubview(transitionImageView)
            container.addSubview(transitionTitleView)
            container.addSubview(transitionSubtitleView)
            container.addSubview(transitionControlButtonView)
            
            UIView.animate(withDuration: duration, animations: {
                transitionImageView.frame =  self.convertFrameToOriginFrame(frame: self.cell.cover.frame)
                transitionTitleView.frame =  self.convertFrameToOriginFrame(frame: self.cell.title.frame)
                transitionSubtitleView.frame =  self.convertFrameToOriginFrame(frame: self.cell.subtitle.frame)
                transitionControlButtonView.frame = self.convertFrameToOriginFrame(frame: self.cell.controlButton.frame)
                detailView.frame = self.originFrame
                detailView.alpha =  0
            }, completion: { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                transitionImageView.removeFromSuperview()
                transitionImageView.removeFromSuperview()
                transitionTitleView.removeFromSuperview()
                transitionSubtitleView.removeFromSuperview()
                transitionControlButtonView.removeFromSuperview()
                detailViewCover?.alpha = 1
                detailViewTitle?.alpha = 1
                detailViewSubitle?.alpha = 1
                detailViewControlButton?.alpha = 1
            })
        }

    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
}


extension CoverTrasition {
    
    func convertFrameToOriginFrame(frame: CGRect) -> CGRect {
        let newFrame = CGRect(x: self.originFrame.origin.x + frame.origin.x, y: self.originFrame.origin.y + frame.origin.y, width: frame.width, height: frame.height)
        return newFrame
    }
    
    func convertFrameByOffset(frame: CGRect) -> CGRect {
        let newFrame = CGRect(x: frame.origin.x, y: frame.origin.y + offsetHeight, width: frame.width, height: frame.height)
        return newFrame
    }
}



