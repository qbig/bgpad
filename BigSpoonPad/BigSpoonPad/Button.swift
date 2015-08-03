import UIKit
import QuartzCore

@IBDesignable
class Button: UIButton
{
  @IBInspectable var ripplePercent: Float = 1 {
    didSet {
      updateUI()
    }
  }
  
  @IBInspectable var rippleOverBounds: Bool = false
  
  @IBInspectable var buttonCornerRadius: Float = 0 {
    didSet {
      layer.cornerRadius = CGFloat(buttonCornerRadius)
    }
  }
  
  @IBInspectable var shadowRippleRadius: Float = 1
  
  let rippleForegroundView = UIView()
  let rippleBackgroundView = UIView()
  private var tempShadowRadius: CGFloat = 0
  private var tempShadowOpacity: Float = 0
  
  private var rippleMask: CAShapeLayer? {
    get {
      if rippleOverBounds
      {
        return nil
      }
      else
      {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).CGPath
        return maskLayer
      }
    }
  }
  
  required init(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  override init(frame: CGRect)
  {
    super.init(frame: frame)
    setup()
  }
  
  private func setup()
  {
    updateUI()
    
    rippleOverBounds = false
    
    rippleBackgroundView.backgroundColor = backgroundColor
    rippleBackgroundView.frame = bounds
    layer.addSublayer(rippleBackgroundView.layer)
    rippleBackgroundView.layer.addSublayer(rippleForegroundView.layer)
    rippleBackgroundView.alpha = 0
    
    layer.shadowRadius = 0
    layer.shadowOffset = CGSize(width: 0, height: 1)
    layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).CGColor
  }
  
  private func updateUI()
  {
    var size: CGFloat = CGRectGetWidth(bounds) * CGFloat(ripplePercent)
    var x: CGFloat = (CGRectGetWidth(bounds)/2) - (size/2)
    var y: CGFloat = (CGRectGetHeight(bounds)/2) - (size/2)
    var corner: CGFloat = size/2
    
    if let backgroundColor = backgroundColor
    {
      rippleForegroundView.backgroundColor = UIColor.adjustValue(backgroundColor, percentage: 1.1)
    }
    rippleForegroundView.frame = CGRectMake(x, y, size, size)
    rippleForegroundView.layer.cornerRadius = corner
  }
  
  override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool
  {
    rippleForegroundView.center = touch.locationInView(self)
    
    UIView.animateWithDuration(0.1, animations: { self.rippleBackgroundView.alpha = 1 }, completion: nil)
    
    rippleForegroundView.transform = CGAffineTransformMakeScale(0.5, 0.5)
    
    UIView.animateWithDuration(0.7,
      delay: 0,
      options: .CurveEaseOut,
      animations: {
        self.rippleForegroundView.transform = CGAffineTransformIdentity
      },
      completion: nil)
    
    tempShadowRadius = layer.shadowRadius
    tempShadowOpacity = layer.shadowOpacity
    
    var shadowAnim = CABasicAnimation(keyPath:"shadowRadius")
    shadowAnim.toValue = shadowRippleRadius
    
    var opacityAnim = CABasicAnimation(keyPath:"shadowOpacity")
    opacityAnim.toValue = 1
    
    var groupAnim = CAAnimationGroup()
    groupAnim.duration = 0.7
    groupAnim.fillMode = kCAFillModeForwards
    groupAnim.removedOnCompletion = false
    groupAnim.animations = [shadowAnim, opacityAnim]
    
    layer.addAnimation(groupAnim, forKey:"shadow")
    
    return super.beginTrackingWithTouch(touch, withEvent: event)
  }
  
  override func endTrackingWithTouch(touch: UITouch, withEvent event: UIEvent)
  {
    super.endTrackingWithTouch(touch, withEvent: event)
    
    UIView.animateWithDuration(0.1,
      animations: {
        self.rippleBackgroundView.alpha = 1
      },
      completion: { success in
        UIView.animateWithDuration(0.6 , animations: { self.rippleBackgroundView.alpha = 0 })
      }
    )
    
    UIView.animateWithDuration(0.7,
      delay: 0,
      options: .CurveEaseOut | .BeginFromCurrentState,
      animations: {
        self.rippleForegroundView.transform = CGAffineTransformIdentity
        
        var shadowAnim = CABasicAnimation(keyPath:"shadowRadius")
        shadowAnim.toValue = self.tempShadowRadius
        
        var opacityAnim = CABasicAnimation(keyPath:"shadowOpacity")
        opacityAnim.toValue = self.tempShadowOpacity
        
        var groupAnim = CAAnimationGroup()
        groupAnim.duration = 0.7
        groupAnim.fillMode = kCAFillModeForwards
        groupAnim.removedOnCompletion = false
        groupAnim.animations = [shadowAnim, opacityAnim]
        
        self.layer.addAnimation(groupAnim, forKey:"shadowBack")
      },
      completion: nil
    )
  }
  
  override func layoutSubviews()
  {
    super.layoutSubviews()
    
    let oldCenter = rippleForegroundView.center
    
    updateUI()
    
    rippleForegroundView.center = oldCenter
    rippleBackgroundView.layer.frame = bounds
    rippleBackgroundView.layer.mask = rippleMask
  }
}