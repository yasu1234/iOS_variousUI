import UIKit

final class CustomSlider: UISlider {
    private let labelSize: CGFloat = 4.0

    var onValueChanged: ((Int) -> Void)?
    private var labelList = [UIView]()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        setup(max: 1)
    }

    private func setup(max: Int) {
        minimumValue = 0
        maximumValue = Float(max)
        
        addTarget(self, action: #selector(onChange), for: .valueChanged)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        fixSliderPosition()
    }
    
    // when you tapped slder, value moves (iOS 12 later option)
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let tapPoint = touch.location(in: self)
        let fraction = Float(tapPoint.x / bounds.width)
        let newValue = (maximumValue - minimumValue) * fraction + minimumValue
        if newValue != value {
            value = newValue
        }
        return true
    }

    // set Max Value
    func updateMaxValue(_ max: Int) {
        maximumValue = Float(max)
        value = min(value, maximumValue)
        updateScaleLabel()
    }
}

private extension CustomSlider {
    @objc func onChange(_ sender: UISlider) {
        onValueChanged?(Int(round(sender.value)))
    }
}

private extension CustomSlider {
    // adjust position when finish sliding
    func fixSliderPosition() {
        let index = round(self.value)
        self.value = index
        onValueChanged?(Int(index))
    }

    // reset position of decreate
    func updateScaleLabel() {
        labelList.forEach({ $0.removeFromSuperview() })
        labelList.removeAll()
        
        // to keep equal space, set below
        // axis: .horizontal
        // distribution: .equalSpacing
        // alignment: .fill
        // spacing: 0
        let labelArea = UIStackView()
        labelArea.axis = .horizontal
        labelArea.distribution = .equalSpacing
        labelArea.alignment = .fill
        labelArea.spacing = 0
        insertSubview(labelArea, at: 0)
        
        labelArea.translatesAutoresizingMaskIntoConstraints = false
        labelArea.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 16).isActive = true

        // set track margin
        let offset = thumbCenterOffset
        labelArea.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: offset).isActive = true
        labelArea.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -offset).isActive = true
        labelArea.heightAnchor.constraint(equalToConstant: labelSize).isActive = true
    
        let max = Int(maximumValue) + 1
        for _ in 0..<max {
            let decreate = createDecreate()
            decreate.widthAnchor.constraint(equalToConstant: labelSize).isActive = true
            labelArea.addArrangedSubview(decreate)
            labelList.append(decreate)
        }
    }

    func createDecreate() -> UIView {
        let label = UIView()
        label.backgroundColor = .black
        label.layer.cornerRadius = CGFloat(labelSize / 2)
        label.bounds.size = CGSize(width: labelSize, height: labelSize)
        return label
    }

    // get the margin of the X coordinate of the thumb center for the left and right ends of the track.
    var thumbCenterOffset: CGFloat {
        let startOffset = trackBounds.origin.x
        let firstThumbPosition = positionX(at: 0)
        return firstThumbPosition - startOffset - labelSize / 2
    }

    // when point to index, get center of x coordinate
    func positionX(at index: Int) -> CGFloat {
        let rect = thumbRect(forBounds: bounds, trackRect: trackBounds, value: Float(index))
        return rect.midX
    }

    var trackBounds: CGRect {
        return trackRect(forBounds: bounds)
    }
}
