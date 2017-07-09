//
//  FileManager+STFramework.swift
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

extension FileManager {
    
    // returns string representing the root of the documents folder
    public static func documentDirectoryPath() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    // returns string representing the root of the caches folder
    public static func cachesDirectoryPath() -> String {
        var documentsPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as [String]
        return documentsPath[0]
    }
    
    // tests if file exists
    @discardableResult
    public static func fileExists(at url: URL) -> Bool {
        return FileManager.default.fileExists(atPath: url.path)
    }
    
    // removes an item
    @discardableResult
    public static func removeItem(at url: URL?) -> Bool {
        guard let url = url else {
            return false
        }
        do {
            try FileManager.default.removeItem(at: url)
            return true
        } catch {
            return false
        }
    }
    
    // moves an item
    @discardableResult
    public static func moveItem(from atUrl: URL?, to toURL: URL?) -> Bool {
        guard let atUrl = atUrl, let toURL = toURL else {
            return false
        }
        do {
            try FileManager.default.moveItem(at: atUrl, to: toURL)
            return true
        } catch {
            return false
        }
    }
    
    // returns an optional URL for a path component in a directory
    public static func url(forPathComponent pathComponent: String, in directory: FileManager.SearchPathDirectory) -> URL? {
        do {
            let url = try FileManager.default.url(for: directory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(pathComponent)
            return url
        } catch {
            return nil
        }
    }
    
    // returns an optional URL for a path component in .documentDirectory
    public static func url(forPathComponentInDocument pathComponent: String) -> URL? {
        return FileManager.url(forPathComponent: pathComponent, in: .documentDirectory)
    }
    
    // returns an optional URL for a path component in .cachesDirectory
    public static func url(forPathComponentInCache pathComponent: String) -> URL? {
        return FileManager.url(forPathComponent: pathComponent, in: .cachesDirectory)
    }    
}

extension String {
    
    // returns string value as a path component starting in the document directory
    public func asURLInDocumentDirectory() -> URL? {
        return FileManager.url(forPathComponentInDocument: self)
    }
    
    // returns string value as a path component starting in the cache directory
    public func asURLInCacheDirectory() -> URL? {
        return FileManager.url(forPathComponentInCache: self)
    }
}

