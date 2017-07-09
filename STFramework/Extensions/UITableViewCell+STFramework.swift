//
//  UITableViewCell+STFramework.swift
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

public struct TableViewCellOptions: OptionSet {
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    public let rawValue: Int
    public static let separatorHidden = TableViewCellOptions(rawValue: 1)
    public static let separatorFillsCell = TableViewCellOptions(rawValue: 2)
    public static let notTappable = TableViewCellOptions(rawValue: 4)
    public static let disabled = TableViewCellOptions(rawValue: 8)
}

extension UITableViewCell {
    
    public func setCellOptions(options: TableViewCellOptions) {
        if options.contains(.separatorHidden) {
            separatorInset = UIEdgeInsetsMake(0, bounds.size.width, 0, 0)
            
        } else if options.contains(.separatorFillsCell) {
            layoutMargins = UIEdgeInsets.zero
            separatorInset = UIEdgeInsets.zero
            
        } else if options.contains(.notTappable) {
            accessoryType = .none
            selectionStyle = .none
            
        } else if options.contains(.disabled) {
            accessoryType = .none
            selectionStyle = .none
            isUserInteractionEnabled = false
        }
    }
}
