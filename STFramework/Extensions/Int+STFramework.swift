//
//  Int+STFramework.swift
//  STFramework - Super Toaster Framework
//
//  Created by Louis de Decker 
//
//  MIT License
//
//  Copyright (c) 2016 Super Toaster - Louis de decker (http://www.supertoaster.be/)
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
    
    public enum SecondsFormatterType {
        case hoursMinutesSeconds, hoursMinutes, minutesSeconds
    }
    
    public func secondsFormatString(withSecondsFormatterType formatterType: SecondsFormatterType? = nil) -> String {
        let seconds = self % 60
        let minutes = (self / 60) % 60;
        let hours = self / 3600
        
        var formatterTypeUnwrapped: SecondsFormatterType = .hoursMinutesSeconds
        if let formatterType = formatterType {
            formatterTypeUnwrapped = formatterType
        }
        switch formatterTypeUnwrapped {
        case .hoursMinutesSeconds:
            return String(format:"%02d:%02d:%02d", hours, minutes, seconds)
        case .hoursMinutes:
            return String(format:"%02d:%02d", hours, minutes)
        case .minutesSeconds:
            return String(format:"%02d:%02d", minutes, seconds)
        }
    }

}

