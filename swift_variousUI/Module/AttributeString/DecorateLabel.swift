import UIKit

class DecorateLabel: UILabel {
    var strokeColor:UIColor = UIColor.white
    var strokeSize:CGFloat = 2.0

    override func drawText(in rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            let textColor = self.textColor

            context.setLineWidth(self.strokeSize)
            context.setLineJoin(CGLineJoin.round)
            context.setTextDrawingMode(.stroke)
            self.textColor = self.strokeColor
            super.drawText(in: rect)

            context.setTextDrawingMode(.fill)
            self.textColor = textColor
        }
        super.drawText(in: rect)
    }
}
