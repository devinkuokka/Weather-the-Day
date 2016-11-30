import UIKit

@IBDesignable
@objc class WeeklyCircleView: CircleView {
    @IBInspectable var textColor : UIColor = UIColor.black {
        didSet { drawText(center: self.center) }
    }
    
    @IBInspectable var textSize : CGFloat = 12.0 {
        didSet { drawText(center: self.center) }
    }
    
    @IBInspectable var textFont : String = "Avenir" {
        didSet { drawText(center: self.center) }
    }
    
    var temp : UILabel?
    var high_low: UILabel?
    var image: UIImageView?
    
    var origin: CGPoint?
    var size: CGSize?
    
    
    override func draw(_ frame: CGRect) {
        super.draw(frame)
        let center = CGPoint(x: frame.midX, y: frame.midY)
        backgroundColor = UIColor.clear
        drawText(center: center)
    }
    
    
    private func drawText(center: CGPoint) {
        let shiftFactor = (2 * radius) - lineWidth
        origin = CGPoint(x: center.x, y: center.y)
        size = CGSize(width: shiftFactor, height: shiftFactor * 0.9)
        
        //let innerCircle = CGRect(origin: origin, size: size)
        
        drawTemp();
        drawImage(name: "Cloud-Lightening");
        drawLowHigh(input: "Low", isLow: true)
        drawLowHigh(input: "##", isLow: true)
        drawLowHigh(input: "High", isLow: false)
        drawLowHigh(input: "##", isLow: false)
        
        
    }
    
    private func drawTemp(){
        temp?.removeFromSuperview()
        let frame = CGRect(x: origin!.x,
                           y: origin!.y - size!.height/4,
                           width: size!.width/4,
                           height: size!.height/2)
        temp = UILabel(frame: frame)
        //temp!.text
        temp!.textColor = textColor
        temp!.font = UIFont(name: textFont, size: textSize)
        temp!.textAlignment = .center
    
        addSubview(temp!)
    }
    
    private func drawImage(name: String) {
        image?.removeFromSuperview()
        let frame = CGRect(x: origin!.x,
                           y: origin!.y + size!.height/4,
                           width: size!.width/4,
                           height: size!.height/2)
        image = UIImageView(frame: frame)
        image!.image = UIImage(named: name)
    }
    
    private func drawLowHigh(input: String, isLow: Bool){
        high_low?.removeFromSuperview()
        var x : CGFloat
        var y : CGFloat
        
        if (isLow){ x = origin!.x - 1.5*(size!.width/4)
        } else { x = origin!.x + 1.5*(size!.width/4) }
        
        if (input == "Low" || input == "High"){ y = origin!.y + (size!.height/6)
        } else { y = origin!.y - (size!.height/6) }
        
        let frame = CGRect(x: x,
                           y: y,
                           width: 1.5*(size!.width/4),
                           height: size!.height/2)
        
        high_low = UILabel(frame: frame)
        high_low!.text = input
        high_low!.textColor = textColor
        high_low!.font = UIFont(name: textFont, size: textSize)
        high_low!.textAlignment = .center
        
        addSubview(high_low!)
    }
    
}
