import UIKit

public extension UIButton {
    enum ButtonStyle: Int {
        case top = 0
        case left = 1
        case right = 2
    }
    
    func setEdgeInsets(style buttonStyle: UIButton.ButtonStyle, space: CGFloat) {
        let spacing = space * 2.0
        
        let titleWidth = titleLabel?.bounds.size.width ?? 0
        let titleHeight = titleLabel?.frame.size.height ?? 0
        
        let imageWidth = imageView?.bounds.size.width ?? 0
        let imageHeight = imageView?.frame.size.height ?? 0
        
        switch buttonStyle {
        case .top:
            titleEdgeInsets = UIEdgeInsets(top: imageHeight + spacing, left: -imageWidth, bottom: 0, right: 0);
            imageEdgeInsets = UIEdgeInsets(top: 0, left: titleWidth / 2.0, bottom: titleHeight + spacing, right: -titleWidth / 2.0);
        case .left:
            titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        case .right:
            titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageWidth - spacing, bottom: 0.0, right: imageWidth)
            imageEdgeInsets = UIEdgeInsets(top: 0.0, left: titleWidth, bottom: 0.0, right: -titleWidth)
        }
        
    }
}
