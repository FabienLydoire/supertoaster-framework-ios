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
    
    // returns an optional URL for a path component in a directory
    public static func url(forPathComponent pathComponent: String, in directory: FileManager.SearchPathDirectory) -> URL? {
        do {
            var pathComponentCleaned = pathComponent
            if pathComponent.hasPrefix("/") {
                pathComponentCleaned = pathComponent.removeFirstCharacter()
            }
            let url = try FileManager.default.url(for: directory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(pathComponentCleaned)
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
    
    // deletes all items from a particular directory that match a specific criteria
    public static func removeItems(at url: URL?, matching: (_ fileName: String) -> Bool) {
        guard let url = url, let itemURLs = listFileURLs(atPath: url.path) else {
            return
        }
        itemURLs.forEach { itemURL in
            // ask calling function if this item needs to be removed
            if matching(itemURL.lastPathComponent) {
                removeItem(at: itemURL)
            }
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
    
    // replaces an item with another
    @discardableResult
    public static func replaceItemAt(_ originalItem: URL?, withItemAt itemAt: URL?) -> Bool {
        guard let originalItem = originalItem, let itemAt = itemAt else {
            return false
        }
        do {
            _ = try FileManager.default.replaceItemAt(originalItem, withItemAt: itemAt)
            return true
        } catch {
            return false
        }
    }
    
    // creates a directory at an URL
    @discardableResult
    public static func createDirectory(at: URL?) -> URL? {
        guard let at = at else {
            return nil
        }
        do {
            try FileManager.default.createDirectory(at: at, withIntermediateDirectories: true, attributes: nil)
            return at
        } catch {
            return nil
        }
    }
    
    // creates a directory in documents
    @discardableResult
    public static func createDirectoryInDocuments(named: String) -> URL? {
        return FileManager.createDirectory(at: named.asURLInDocumentDirectory())
    }
    
    // returns file names for a given path
    public static func listFileNames(atPath path: String) -> [String]? {
        do {
            let contentsOfDirectory = try FileManager.default.contentsOfDirectory(atPath: path)
            return contentsOfDirectory
        } catch {
            return nil
        }
    }
   
    // returns file URLs contained in a directory
    public static func listFileURLs(atPath path: String) -> [URL]? {
        guard let fileNames = FileManager.listFileNames(atPath: path) else {
            return nil
        }
        var pathString = path
        // add "/" if path does not finished with /
        if !pathString.hasSuffix("/") {
            pathString += "/"
        }
        let fileURLs = fileNames.map { fileName -> URL? in
            return URL(fileURLWithPath: "\(pathString)\(fileName)")
        }
        // return array of non-nil items
        return fileURLs.flatMap { return $0 }
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

