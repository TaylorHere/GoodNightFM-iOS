import UIKit

class CoverTrasition : NSObject, UIViewControllerAnimatedTransitioning {
    var duration : TimeInterval
    var isPresenting : Bool
    var originFrame : CGRect
    var cell : CradCell
    public let CustomAnimatorTag = 99
    
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

        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }

        self.isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
        
        let detailViewContoller: DetailViewController = (isPresenting ? toViewController : fromViewController) as! DetailViewController
        let detailView = isPresenting ? toView : fromView
        
        let detailViewimage = detailViewContoller.cover
        let detailViewTitle = detailViewContoller._title
        let detailViewSubitle = detailViewContoller.subtitle
        let detailViewControlButton = detailViewContoller.controllButton
        
        detailViewimage?.image = cell.cover.image
        detailViewimage?.alpha = 0
        
        let transitionImageView = UIImageView(frame: isPresenting ? convertFrameToOriginFrame(frame: cell.cover.frame) : detailViewimage!.frame)
        let transitionTitleView = UILabel(frame: isPresenting ? convertFrameToOriginFrame(frame: cell.title.frame)  : detailViewTitle!.frame)
        let transitionSubtitleView = UILabel(frame: isPresenting ? convertFrameToOriginFrame(frame: cell.subtitle.frame)  : detailViewSubitle!.frame)
        let transitionControlButtonView = UIImageView(frame: isPresenting ? convertFrameToOriginFrame(frame: cell.controlButton.frame)  : detailViewControlButton!.frame)
        
        transitionImageView.image = cell.cover.image
        transitionTitleView.text = cell.title.text
        transitionSubtitleView.text = cell.subtitle.text
        transitionControlButtonView.image = cell.controlButton.image
        
        container.addSubview(transitionImageView)
        container.addSubview(transitionTitleView)
        container.addSubview(transitionSubtitleView)
        container.addSubview(transitionControlButtonView)

        toView.frame = isPresenting ? transitionImageView.frame : toView.frame
        toView.alpha = isPresenting ? 0 : 1
        toView.layoutIfNeeded()
//
        UIView.animate(withDuration: duration, animations: {
            transitionImageView.frame = self.isPresenting ? detailViewimage!.frame : self.originFrame
            transitionTitleView.frame = self.isPresenting ? detailViewTitle!.frame : self.originFrame
            transitionSubtitleView.frame = self.isPresenting ? detailViewSubitle!.frame : self.originFrame
            transitionControlButtonView.frame = self.isPresenting ? detailViewControlButton!.frame : self.originFrame
            detailView.frame = self.isPresenting ? fromView.frame : transitionImageView.frame
            detailView.alpha = self.isPresenting ? 1 : 0
        }, completion: { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            transitionImageView.removeFromSuperview()
            transitionImageView.removeFromSuperview()
            transitionTitleView.removeFromSuperview()
            transitionSubtitleView.removeFromSuperview()
            transitionControlButtonView.removeFromSuperview()
            detailViewimage?.alpha = 1
        })
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
}



