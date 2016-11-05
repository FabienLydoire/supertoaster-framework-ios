//
//  Date+STFramework.swift
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

public enum DateFormatType: String {
    case spacing = " "
    case dayMonthYearHourMinuteSecond = "dd/MM/yyyy HH:mm:ss"
    case dayMonthYear = "dd/MM/yyyy"
    case hourMinuteSecond = "HH:mm:ss"
    case sqlDate = "yyyy-MM-dd"
    case sqlDateFormat = "yyyy-MM-dd HH:mm:ss"
    case sqlDateFormatDashed = "yyyy-MM-dd-HH-mm-ss"
    
}

extension Date {
    
    public static var unixTimeStamp: String {
        return "\(Int(Date().timeIntervalSince1970))"
    }
    
    public func string(withDateFormatType formatTypes: [DateFormatType]) -> String {
        var formatString = ""
        for formatType in formatTypes {
            formatString += formatType.rawValue
        }
        return string(withStringFormat: formatString)
    }
    
    public func string(withDateFormatType formatType: DateFormatType) -> String {
        return string(withStringFormat: formatType.rawValue)
    }
    
    public func string(withStringFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    public static var timestamp: String {
        let dateString = Date().string(withStringFormat: "yyyy-MM-dd_HH-mm-ss_SSS")
        let randomValue = arc4random_uniform(10000)
        let uniqueString = String(format: "%@_%04d", dateString, randomValue)
        return uniqueString
    }
    
    // MARK: TimeZone related
    public var gmt0Date: Date {
        let timeZone = TimeZone.current
        let secondsFromGMT = -timeZone.secondsFromGMT(for: self)
        let gmt0Date = Date(timeInterval: TimeInterval(secondsFromGMT), since: self)
        return gmt0Date
    }
    
    public static var gmt0Date: Date {
        return Date().gmt0Date
    }
    
    public var deviceDate: Date {
        let timeZone = TimeZone.current
        let secondsFromGMT = timeZone.secondsFromGMT(for: self)
        let gmt0Date = Date(timeInterval: TimeInterval(secondsFromGMT), since: self)
        return gmt0Date
    }
    
    public static var deviceDate: Date {
        return Date().deviceDate
    }   
    
}
