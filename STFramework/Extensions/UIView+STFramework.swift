//
//  UIView+STFramework.swift
//  STFramework - Super Toaster Framework
//
//  Created by Louis de Decker 
//
//  MIT License
//
//  Copyright (c) 2016 Super Toaster - Louis de decker (http://www.supertoaster.be/)
//  source: https://github.com/supertoasteragency/supertoaster-framework-ios
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

extension UIView {
    
    // MARK: View attributes
    public var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var newFrame = frame
            newFrame.origin.x = newValue
            frame = newFrame
        }
    }
    
    public var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            var newFrame = frame
            newFrame.origin.y = newValue
            frame = newFrame
        }
    }
    
    public var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            var newFrame = frame
            newFrame.size.width = newValue
            frame = newFrame
        }
    }
    
    public var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            var newFrame = frame
            newFrame.size.height = newValue
            frame = newFrame
        }
    }
    
    public var size: CGSize {
        get {
            return frame.size
        }
        set {
            var newFrame = frame
            newFrame.size = newValue
            frame = newFrame
        }
    }
    
    // MARK: show/hide
    // fades in view alpha
    public func fadeIn(withDuration duration: TimeInterval?) {
        isHidden = false
        alpha = 0
        UIView.animate(withDuration: duration ?? 0.5, animations: {
            self.alpha = 1
        })
    }
    
    // fades out view alpha
    public func fadeOut(withDuration duration: TimeInterval?) {
        isHidden = false
        alpha = 1
        UIView.animate(withDuration: duration ?? 0.5, animations: {
            self.alpha = 0
        }) { finished in
            self.isHidden = true
        }
    }    
    
    // MARK: - NSLayoutConstraint helpers
    // MARK: Size
    public var layoutConstraintSuperview: UIView? {
        if let superview = superview {
            translatesAutoresizingMaskIntoConstraints = false
            return superview
        } else {
            return nil
        }
    }
    
    public func layoutConstraintSet(width: CGFloat) {
        if let superview = layoutConstraintSuperview {
            superview.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width))
        }
    }
    
    public func layoutConstraintSet(height: CGFloat) {
        if let superview = layoutConstraintSuperview {
            superview.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height))
        }
    }
    
    public func layoutConstraintSet(width: CGFloat, height: CGFloat) {
        layoutConstraintSet(width: width)
        layoutConstraintSet(height: height)
    }
    
    public func layoutConstraintSet(size: CGSize) {
        layoutConstraintSet(width: size.width)
        layoutConstraintSet(height: size.height)
    }
    
    // MARK: Alignment
    public func layoutConstraintCenterInSuperview() {
        if let superview = layoutConstraintSuperview {
            superview.addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1, constant: 0))
            superview.addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1, constant: 0))
        }
    }
    
    public enum LayoutAlignType {
        case top, bottom, left, right, centerX, centerY
        
        public var layoutAttribute: NSLayoutAttribute {
            switch self {
            case .top:
                return .top
            case .bottom:
                return .bottom
            case .left:
                return .leading
            case .right:
                return .trailing
            case .centerX:
                return .centerX
            case .centerY:
                return .centerY
            }
        }
        
        public func constant(value: CGFloat) -> CGFloat {
            switch self {
            case .top:
                return value
            case .bottom:
                return -value
            case .left:
                return value
            case .right:
                return -value
            case .centerX:
                return value
            case .centerY:
                return -value
            }
        }
        
        public static var topLeft: [LayoutAlignType] {
            return [.top, .left]
        }
        public static var topRight: [LayoutAlignType] {
            return [.top, .right]
        }
        public static var bottomLeft: [LayoutAlignType] {
            return [.bottom, .left]
        }
        public static var bottomRight: [LayoutAlignType] {
            return [.bottom, .right]
        }
    }
    
    public func layoutConstraintAlignToSuperView(_ alignTypes: [LayoutAlignType], paddings: [CGFloat]? = nil) {
        if let superview = layoutConstraintSuperview, alignTypes.count == 2 {
            for i in 0 ..< alignTypes.count {
                let alignType = alignTypes[i]
                var padding: CGFloat = 0
                if let paddings = paddings {
                    padding = paddings[i]
                }
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: alignType.layoutAttribute, relatedBy: .equal, toItem: superview, attribute: alignType.layoutAttribute, multiplier: 1, constant: alignType.constant(value: padding)))
            }
        }
    }
    
    public func layoutConstraintFillToSuperView(padding: UIEdgeInsets? = nil) {
        if let superview = layoutConstraintSuperview {
            var paddingValue = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            if let padding = padding {
                paddingValue = padding
            }
            superview.addConstraint(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superview, attribute: .leading, multiplier: 1, constant: paddingValue.left))
            superview.addConstraint(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: superview, attribute: .trailing, multiplier: 1, constant: -paddingValue.right))
            superview.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: paddingValue.top))
            superview.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1, constant: -paddingValue.bottom))
        }
    }
    
}


extension Collection where Iterator.Element == UIView {
    
    // hides all views contained in an array
    public func hideViews() {
        self.forEach { view in
            view.isHidden = true
        }
    }
    
    // hides all views contained in an array
    public func showViews() {
        self.forEach { view in
            view.isHidden = false
        }
    }
    
}
