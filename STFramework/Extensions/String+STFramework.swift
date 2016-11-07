//
//  String+STFramework.swift
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

extension String {
    
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    public func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    public func isEqualCaseInsensitiveWith(string: String) -> Bool {
        return self.caseInsensitiveCompare(string) == .orderedSame
    }
    
    public var isAnEmail: Bool {
        return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}").evaluate(with: self)
    }
    
    public var isNotAnEmail: Bool {
        return !isAnEmail
    }
    
    public var isNotEmpty: Bool {
        return !self.isEmpty
    }
    
    public var isEmptyTrimmed: Bool {
        return self.trim().isEmpty
    }
    
    public var isNotEmptyTrimmed: Bool {
        return !isEmptyTrimmed
    }
    
    public func contains(string: String) -> Bool {
        return self.range(of: string) != nil
    }
    
    public func containsCaseInsensitive(string: String) -> Bool {
        return self.lowercased().range(of: string.lowercased()) != nil
    }
    
    public func appendDate(separator: String? = nil) -> String {
        let separatorString = separator ?? ""
        return "\(self)\(separatorString)\(Date().string(withDateFormatType: .sqlDateFormatDashed))"
    }
    
    public func prependDate(separator: String? = nil) -> String {
        let separatorString = separator ?? ""
        return "\(Date().string(withDateFormatType: .sqlDateFormatDashed))\(separatorString)\(self)"
    }
    
    public var length: Int {        
        return self.characters.count
    }
    
    public func substringAt(index: Int) -> String? {
        if index < 0 || index >= self.length {
            return nil
        } else {
            return String(self.characters[self.index(self.startIndex, offsetBy: index)])
        }
    }
    
    // returns uuid string with format "6E20B04C-11FF-4F1A-A239-BFF5DB17CAE5"
    public static func UUIDString() -> String {
        return NSUUID().uuidString
    }
    
    public func appendUUIDString() -> String {
        return "\(self)\(String.UUIDString())"
    }
    
    // returns uuid string with format "A31B3789-95C2-4122-A251-28ED88E77967-58509-000033D2E963799"
    public static func UUIDGlobalString() -> String {
        return ProcessInfo().globallyUniqueString
    }
    
    public func appendUUIDGlobalString() -> String {
        return "\(self)\(String.UUIDGlobalString())"
    }
    
    func dataUsingUTF8() -> Data? {
        return self.data(using: .utf8)
    }
    
}

