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
    
    func testRemovingFile() {
        let fileURL = urlForRandomFile()
        XCTAssert(FileManager.fileExists(at: fileURL))
        XCTAssertTrue(FileManager.removeItem(at: fileURL))
        XCTAssertFalse(FileManager.fileExists(at: fileURL))
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
    
    
    func urlForRandomFile() -> URL {
        let url = String.UUIDString().asURLInDocumentDirectory()
        XCTAssertNotNil(url)
        let dict: [String: Any] = ["a": "a", "b": "b"]
        guard let saveUrl = url, dict.saveAsPlist(to: saveUrl) else {
            XCTAssert(false)
            return URL(fileURLWithPath: "")
        }
        return saveUrl
    }
}
