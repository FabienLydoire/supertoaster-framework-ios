//
//  UserDefaults+STFramework.swift
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

extension UserDefaults {
    
    public static func setBool(_ value: Bool, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    public static func bool(forKey key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    public static func setString(_ value: String, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    public static func string(forKey key: String) -> String? {
        if let value = UserDefaults.standard.value(forKey: key) as? String {
            return value
        } else {
            return nil
        }
    }
    
    public static func setAnyValue(_ value: Any, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    public static func anyValue(forKey key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
    
}

