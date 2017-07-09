//
//  Random+STFramework.swift
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

extension Int {
    
    // uses current value as ahe
    public var asRandomMaxValue: Int {
        return Int.random(betweenZeroAnd: self)
    }
    
    // returns a random int value between 0 and the value provided
    public static func random(betweenZeroAnd value: Int) -> Int {
        let adjustedValue = value + 1
        guard value > 0 && adjustedValue > 1 else {
            return 0
        }
        return Int(arc4random_uniform(UInt32(adjustedValue)))
    }
    
    // returns a random int value between a range of values
    public static func random(between: Int, and: Int) -> Int {
        let randomAmplitude = and - between
        guard between < and, randomAmplitude > 0 else {
            return between
        }
        return between + randomAmplitude.asRandomMaxValue
    }
}

extension Bool {
    // returns true/false randomly, 50% chance
    public static func random() -> Bool {
        return arc4random_uniform(2) == 0
    }
}

extension CountableClosedRange {
    // returns a random Int between the lower and upper bound
    public func random() -> Int {
        guard !isEmpty, let min = lowerBound as? Int, let max = upperBound as? Int else {
            return 0
        }
        return Int.random(between: min, and: max)
    }
}
