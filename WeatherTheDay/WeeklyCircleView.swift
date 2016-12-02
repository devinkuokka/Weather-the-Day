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
    
    var origin: CGPoint?
    var size: CGSize?
    
    
    override func draw(_ frame: CGRect) {
        super.draw(frame)
        let center = CGPoint(x: 3*lineWidth, y: 2*lineWidth)
        backgroundColor = UIColor.clear
        drawText(center: center)
    }
    
    
    private func drawText(center: CGPoint) {
        let shiftFactor = (2 * radius) - lineWidth
        origin = CGPoint(x: center.x, y: center.y)
        size = CGSize(width: shiftFactor, height: shiftFactor)
        
        drawTemp();
        drawImage(name: "Cloud-Lightening");
        drawLowHigh(input: "Low", isLow: true)
        drawLowHigh(input: "###", isLow: true)
        drawLowHigh(input: "High", isLow: false)
        drawLowHigh(input: "###", isLow: false)
        
        
    }
    
    private func drawTemp(){
        var temp : UILabel?

        temp?.removeFromSuperview()
        let frame = CGRect(x: size!.width*0.5 - size!.width*0.1,
                           y: size!.height*0.66,
                           width: size!.width*0.5,
                           height: size!.height*0.5)
        temp = UILabel(frame: frame)
        temp!.text = "###"
        temp!.textColor = UIColor(red: 32/255, green: 118/255, blue: 200/255, alpha: 1)
        temp!.font = UIFont(name: textFont, size: 50)
        temp!.textAlignment = .center

    
        addSubview(temp!)
    }
    
    private func drawImage(name: String) {
        var image: UIImageView?

        image?.removeFromSuperview()
        let frame = CGRect(x: size!.width*0.5 - size!.width*0.1,
                           y: size!.height*0.33,
                           width: size!.width*0.5,
                           height: size!.height*0.5)
        image = UIImageView(frame: frame)
        image!.image = UIImage(named: name)
    }
    
    private func drawLowHigh(input: String, isLow: Bool){
        var high_low: UILabel?

        high_low?.removeFromSuperview()
        var x : CGFloat
        var y : CGFloat
        var t : CGFloat
        
        if (isLow){
            x = origin!.x
        } else {
            x = size!.width*0.75
        }
        
        if (input == "Low" || input == "High"){
            y = origin!.y + size!.height*0.15
            t = 20;
        } else {
            y = origin!.y + size!.height*0.3
            t = 30
        }
        
        let frame = CGRect(x: x,
                           y: y,
                           width: 1.5*(size!.width*0.25),
                           height: size!.height*0.5)
        
        high_low = UILabel(frame: frame)
        high_low!.text = input
        high_low!.textColor = UIColor(red: 201/255, green: 74/255, blue: 22/255, alpha: 1)
        high_low!.font = UIFont(name: textFont, size: t)
        high_low!.textAlignment = .center
        
        addSubview(high_low!)
    }
}
