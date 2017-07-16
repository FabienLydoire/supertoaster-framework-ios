//
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

import XCTest
import STFramework

@testable import STFramework

class ExtensionsFileManagerTests: XCTestCase {
    
    func test() {
        XCTAssert(FileManager.documentDirectoryPath().length > 0)
        XCTAssert(FileManager.cachesDirectoryPath().length > 0)
        XCTAssertNotNil("test".asURLInDocumentDirectory())
        XCTAssertNotNil("test".asURLInCacheDirectory())
        XCTAssertNotNil(FileManager.url(forPathComponent: "a", in: .documentDirectory))
        XCTAssertNotNil(FileManager.url(forPathComponentInDocument: "a"))
        XCTAssertNotNil(FileManager.url(forPathComponentInCache: "a"))
    }
    
    func testRemoveItem() {
        let fileURL = urlForRandomFile()
        XCTAssert(FileManager.fileExists(at: fileURL))
        XCTAssertTrue(FileManager.removeItem(at: fileURL))
        XCTAssertFalse(FileManager.fileExists(at: fileURL))
    }
    
    func testRemoveItems() {
        let path = "\(Date.timestamp)/a/"
        guard let dir = FileManager.createDirectoryInDocuments(named: path) else {
            XCTAssert(false)
            return
        }
        let itemsToKeepCount = 5
        let itemsToDeleteCount = 2
        for i in 0..<itemsToKeepCount {
            createFile(atURL: URL(fileURLWithPath: "\(dir.path)/\(i).txt"))
        }
        for i in 0..<itemsToDeleteCount {
            createFile(atURL: URL(fileURLWithPath: "\(dir.path)/\(i).jpg"))
        }
        XCTAssert(FileManager.listFileNames(atPath: dir.path)?.count == itemsToKeepCount + itemsToDeleteCount)
        // remove all items that finish with .jpg
        FileManager.removeItems(at: dir) { fileName -> Bool in
            return fileName.hasSuffix(".jpg")
        }
        XCTAssert(FileManager.listFileNames(atPath: dir.path)?.count == itemsToKeepCount)
    }
    
    func testMovingFile() {
        let sourceFileURL = urlForRandomFile()
        guard let destinationURL = "destination".asURLInDocumentDirectory() else {
            XCTAssert(false)
            return
        }
        FileManager.removeItem(at: destinationURL)
        XCTAssertTrue(FileManager.moveItem(from: sourceFileURL, to: destinationURL))
        XCTAssertFalse(FileManager.fileExists(at: sourceFileURL))
        XCTAssertTrue(FileManager.fileExists(at: destinationURL))
    }
    
    func testReplaceFile() {
        let fileA = urlForDictFile(withValue: "A")
        let fileB = urlForDictFile(withValue: "B")
        XCTAssertTrue(FileManager.replaceItemAt(fileA, withItemAt: fileB))
        XCTAssertFalse(FileManager.fileExists(at: fileB))
        XCTAssertTrue(FileManager.fileExists(at: fileA))
    }
    
    func testCreateDirectory() {
        XCTAssertNotNil(FileManager.createDirectory(at: "\(Date.timestamp)/b/b/c/d".asURLInDocumentDirectory()))
        XCTAssertNotNil(FileManager.createDirectoryInDocuments(named: "\(Date.timestamp)/a/b/c/d"))
    }
    
    func testListFiles() {
        let path = "\(Date.timestamp)/a/"
        guard let dir = FileManager.createDirectoryInDocuments(named: path) else {
            XCTAssert(false)
            return
        }
        let itemCount = 5
        for i in 0..<itemCount {
            createFile(atURL: URL(fileURLWithPath: "\(dir.path)/\(i).txt"))
        }
        XCTAssert(FileManager.listFileNames(atPath: dir.path)?.count == itemCount)
        let urls = FileManager.listFileURLs(atPath: dir.path)
        XCTAssert(urls?.count == itemCount)
    }
    
    // helpers
    private func urlForRandomFile() -> URL {
        let dict: [String: Any] = ["a": "a", "b": "b"]
        guard let saveUrl = String.UUIDString().asURLInDocumentDirectory(), dict.saveAsPlist(to: saveUrl) else {
            XCTAssert(false)
            return URL(fileURLWithPath: "")
        }
        return saveUrl
    }
    
    private func urlForDictFile(withValue value: String) -> URL {
        let dict: [String: Any] = ["value": value]
        guard let saveUrl = String.UUIDString().asURLInDocumentDirectory(), dict.saveAsPlist(to: saveUrl) else {
            XCTAssert(false)
            return URL(fileURLWithPath: "")
        }
        return saveUrl
    }
    
    private func createFile(atURL url: URL) {
        let dict: [String: Any] = ["value": "a"]
        guard dict.saveAsPlist(to: url) else {
            XCTAssert(false)
            return
        }
    }
    
}
