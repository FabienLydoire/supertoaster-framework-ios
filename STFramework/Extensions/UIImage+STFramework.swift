//
//  UIImage+STFramework.swift
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

extension UIImage {
    public var width: CGFloat {
        return size.width
    }
    
    public var height: CGFloat {
        return size.width
    }
    
    @discardableResult
    public func saveAsJPG(quality: CGFloat, toPath path: String) -> Bool {
        var success = false
        let imageData = UIImageJPEGRepresentation(self, quality)
        do {
            try imageData?.write(to:URL(fileURLWithPath: path), options: Data.WritingOptions.atomic)
            success = true
        } catch {
        }
        return success
    }
}

