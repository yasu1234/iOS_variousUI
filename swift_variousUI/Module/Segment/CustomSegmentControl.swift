import UIKit

class CustomSegmentControl: UISegmentedControl {
    private let segmentRadius = 30
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let selectedAttribute: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: UIFont.labelFontSize),
            NSAttributedString.Key.foregroundColor : UIColor.blue
        ]

        // UIFont.labelFontSize is crash, set UIFont.systemFon
        let highLightAttribute: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: UIFont.labelFontSize),
            NSAttributedString.Key.foregroundColor : UIColor.green
        ]

        setTitleTextAttributes(highLightAttribute, for: .normal)
        setTitleTextAttributes(selectedAttribute, for: .selected)
        setTitleTextAttributes(highLightAttribute, for: .highlighted)

        layer.masksToBounds = true
        selectedSegmentTintColor = .cyan
        backgroundColor = .red

        let maskedCorner: CACornerMask = [
            .layerMaxXMaxYCorner,
            .layerMaxXMinYCorner,
            .layerMinXMaxYCorner,
            .layerMinXMinYCorner
        ]

        //background
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorner

        // segment default background is hidden to customize background
        for i in 0...(numberOfSegments - 1) {
            let backgroundSegmentView = subviews[i]
            backgroundSegmentView.isHidden = true
        }

        let foregroundIndex = numberOfSegments

        // set round corner default background and selected background
        if subviews.indices.contains(foregroundIndex),
           let foregroundImageView = subviews[foregroundIndex] as? UIImageView {
            foregroundImageView.image = UIImage()
            foregroundImageView.clipsToBounds = true
            foregroundImageView.layer.masksToBounds = true
            foregroundImageView.backgroundColor = .brown

            foregroundImageView.layer.cornerRadius = 16
            foregroundImageView.layer.maskedCorners = maskedCorner
        }
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
