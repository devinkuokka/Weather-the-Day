import UIKit

@IBDesignable
@objc class InfoCircleView: CircleView {
    var text : String = "" {
        didSet { drawText(center: self.center) }
    }
    
    @IBInspectable var textColor : UIColor = UIColor.black {
        didSet { drawText(center: self.center) }
    }
    
    @IBInspectable var textSize : CGFloat = 12.0 {
        didSet { drawText(center: self.center) }
    }
    
    @IBInspectable var textFont : String = "Avenir" {
        didSet { drawText(center: self.center) }
    }
    
    var label : UILabel?

    
    override func draw(_ frame: CGRect) {
        super.draw(frame)
        let center = CGPoint(x: frame.midX, y: frame.midY)
        backgroundColor = UIColor.clear
        drawText(center: center)
    }
    
    
    private func drawText(center: CGPoint) {
        let shiftFactor = (2 * radius) - lineWidth
        let origin = CGPoint(x: center.x, y: center.y)
        let size = CGSize(width: shiftFactor, height: shiftFactor * 0.9)
        
        let innerCircle = CGRect(origin: origin, size: size)
        
        label?.removeFromSuperview()
        label = UILabel(frame: innerCircle)
        label!.text = text
        label!.textColor = textColor
        label!.font = UIFont(name: textFont, size: textSize)
        label!.textAlignment = .center
        label!.center = center
        label!.numberOfLines = 4
        label!.adjustsFontSizeToFitWidth = true
        label!.lineBreakMode = .byWordWrapping
        
        addSubview(label!)
    }
    
}
