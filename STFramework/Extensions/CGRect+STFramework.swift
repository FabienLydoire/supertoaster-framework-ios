//
//  CGRect+STFramework.swift
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

extension CGRect {
    
    // returns rect with no size
    public static func none() -> CGRect {
        return CGRect(x: 0, y: 0, width: 0, height: 0)
    }
    
    // returns rect with a 1x1 size
    public static func oneByOne() -> CGRect {
        return CGRect(x: 0, y: 0, width: 1, height: 1)
    }
    
    public var x: CGFloat {
        get {
            return origin.x
        }
        set {
            var newRect = self
            newRect.origin.x = newValue
            self = newRect
        }
    }
    
    public var y: CGFloat {
        get {
            return origin.y
        }
        set {
            var newRect = self
            newRect.origin.y = newValue
            self = newRect
        }
    }
    
    public var rectWidth: CGFloat {
        get {
            return size.width
        }
        set {
            var newRect = self
            newRect.size.width = newValue
            self = newRect
        }
    }
    
    public var rectHeight: CGFloat {
        get {
            return size.height
        }
        set {
            var newRect = self
            newRect.size.height = newValue
            self = newRect
        }
    }
    
    public var left: CGFloat {
        get {
            return x
        }
        set {
            x = newValue
        }
    }
    
    public var right: CGFloat {
        get {
            return maxX
        }
        set {
            x = newValue - width
        }
    }
    
    public var top: CGFloat {
        get {
            return y
        }
        set {
            y = newValue
        }
    }
    
    public var bottom: CGFloat {
        get {
            return maxY
        }
        set {
            y = newValue - height
        }
    }
}

