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
    
    public var bottom: CGFloat {
        get {
            return y + height
        }
        set {
            y = newValue - height
        }
    }
    
    public var right: CGFloat {
        get {
            return x + width
        }
        set {
            x = newValue - width
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
        UIView.animate(withDuration: duration ?? 0.25, animations: {
            self.alpha = 1
        })
    }
    
    // fades out view alpha
    public func fadeOut(withDuration duration: TimeInterval?) {
        isHidden = false
        alpha = 1
        UIView.animate(withDuration: duration ?? 0.25, animations: {
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
    
    // adds NSLayoutConstraints with the same attribute for both target view and superView
    public func layoutConstraintAddEqualAttributesToSuperView(_ attributes: NSLayoutAttribute...) {
        if let superview = layoutConstraintSuperview {
            attributes.forEach({ attribute in
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: superview, attribute: attribute, multiplier: 1, constant: 0))
            })
        }
    }
    
    // adds NSLayoutConstraints with the same attribute and constant for both target view and superView
    public func layoutConstraintAddEqualAttributesToSuperView(_ attributes: (NSLayoutAttribute, CGFloat)...) {
        if let superview = layoutConstraintSuperview {
            attributes.forEach({ attribute in
                superview.addConstraint(NSLayoutConstraint(item: self, attribute: attribute.0, relatedBy: .equal, toItem: superview, attribute: attribute.0, multiplier: 1, constant: attribute.1))
            })
        }
    }
    
    // removes all constraints on a given view
    public func removeConstraints() {
        constraints.forEach { constraint in
            self.removeConstraint(constraint)
        }
    }
    
    // distributes views horizontally in current view. [views] must already have a width/height constraint
    public func distribute(viewsHorizontally views: [UIView], withPadding padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        enum DistributedViewType {
            case view(UIView), spacer(UIView)
        }
        func newSpacer() -> DistributedViewType {
            let spacer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            spacer.backgroundColor = .clear
            addSubview(spacer)
            return .spacer(spacer)
        }
        
        var distributedViews: [DistributedViewType] = []
        distributedViews.append(newSpacer())
        views.forEach { view in
            distributedViews.append(.view(view))
            addSubview(view)
            distributedViews.append(newSpacer())
        }
        let firstViewItem = views[0]
        var firstSpacer: UIView? = nil
        var firstView: UIView? = nil
        var previousView: UIView? = nil
        for i in 0..<distributedViews.count {
            let distributedView = distributedViews[i]
            let currentView: UIView
            switch distributedView {
            case .spacer(let spacer):
                currentView = spacer
                if let firstSpacer = firstSpacer {
                    // all other spacers have same width as first spacer
                    addConstraint(NSLayoutConstraint(item: spacer, attribute: .width, relatedBy: .equal, toItem: firstSpacer, attribute: .width, multiplier: 1, constant: 0))
                } else {
                    // first spacer, do nothing
                    firstSpacer = spacer
                }
                addConstraint(NSLayoutConstraint(item: currentView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1))
            case .view(let view):
                currentView = view
                if firstView == nil {
                    firstView = view
                    addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: padding.top))
                }
            }
            currentView.translatesAutoresizingMaskIntoConstraints = false
            addConstraint(NSLayoutConstraint(item: currentView, attribute: .top, relatedBy: .equal, toItem: firstViewItem, attribute: .top, multiplier: 1, constant: 0))
            if let previousView = previousView {
                // all currentView's .leading snaps to the previousView's .trailing
                addConstraint(NSLayoutConstraint(item: currentView, attribute: .leading, relatedBy: .equal, toItem: previousView, attribute: .trailing, multiplier: 1, constant: 0))
                if i >= distributedViews.count - 1 {
                    // lase view, align trailing to current view's trailing
                    addConstraint(NSLayoutConstraint(item: currentView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -padding.right))
                }
            } else {
                // first view, align leading to current view's leading
                addConstraint(NSLayoutConstraint(item: currentView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: padding.left))
            }
            previousView = currentView
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

