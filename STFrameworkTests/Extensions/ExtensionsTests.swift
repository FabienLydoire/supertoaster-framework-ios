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

class ExtensionsTests: XCTestCase {
    
    func testString() {
        
        let string = " string "
        XCTAssert(string.trim().length == 6)
        XCTAssert(string.trim().length == 6)

        XCTAssertFalse("string" == "String")
        XCTAssert("string".isEqualCaseInsensitiveWith(string: "String"))

        XCTAssert("test@domain.com".isAnEmail)
        XCTAssertFalse("test@domain".isAnEmail)
        
        XCTAssert("test@domain".isNotAnEmail)
        XCTAssertFalse("test@domain.com".isNotAnEmail)
        
        
        XCTAssert(" ".isEmptyTrimmed)
        XCTAssert(" a".isNotEmptyTrimmed)

        XCTAssert(string.contains("ing"))
        XCTAssertFalse(string.contains("inG"))
        XCTAssert(string.containsCaseInsensitive(string: "inG"))
 
        XCTAssert(string.appendDate().isNotEmptyTrimmed)
        XCTAssert(string.appendDate(separator: "--").contains(string: "--"))
        
        XCTAssert(string.prependDate().isNotEmptyTrimmed)
        XCTAssert(string.prependDate(separator: "--").contains(string: "--"))
        
        
        XCTAssert(String.UUIDString().isNotEmpty)
        XCTAssert(string.appendUUIDString().length > string.length)
        XCTAssert(String.UUIDGlobalString().isNotEmpty)
        XCTAssert(string.appendUUIDGlobalString().length > string.length)
        
        
        XCTAssertNil(String.stringIfNotEmpty(nil))
        XCTAssertNil(String.stringIfNotEmpty(""))
        XCTAssertNotNil(String.stringIfNotEmpty("a"))


    }
    
    func testArray() {
        let array = ["c", "a", "b"]
        XCTAssert(array.isNotEmpty)
        XCTAssert(array.sortedInverse()[0] == "c") 
        
    }
    
    func testData() {
        let string = "string"
        if let dataFromString = string.dataUsingUTF8() {
            XCTAssertNotNil(dataFromString)
            if let stringFromData = dataFromString.stringUsingUTF8() {
                XCTAssertNotNil(stringFromData)
            }
        }
    }
    
    func testDate() {
        XCTAssertTrue(Date().string(withDateFormatType: [.dayMonthYear, .spacing, .dayMonthYear]).isNotEmpty)
        
        XCTAssertTrue(Date.unixTimeStamp.isNotEmpty)
        XCTAssertTrue(Date.timestamp.isNotEmpty)
        
        XCTAssertNotNil(Date.gmt0Date)
        XCTAssertNotNil(Date().gmt0Date)
        
        XCTAssertNotNil(Date.deviceDate)
        XCTAssertNotNil(Date().deviceDate)
    }
    
    func testDateFormatter() {
        XCTAssertNotNil(DateFormatter.sharedInstance)
        XCTAssertNotNil(DateFormatter.sharedInstance(withDateFormat: DateFormatType.dayMonthYear.rawValue))
        XCTAssertNotNil(DateFormatter.sharedInstance(withDateFormatType: .dayMonthYear))
    }
    
    func testInt() {
        let seconds = 59+1+3600+1
        XCTAssertTrue(seconds.secondsFormatString(withSecondsFormatterType: .hoursMinutesSeconds) == "01:01:01")
        XCTAssertTrue(seconds.secondsFormatString() == "01:01:01")
        XCTAssertTrue(seconds.secondsFormatString(withSecondsFormatterType: .hoursMinutes) == "01:01")
        XCTAssertTrue(seconds.secondsFormatString(withSecondsFormatterType: .minutesSeconds) == "01:01")
    }
    
    func testRect() {
        var r = CGRect(x: 0, y: 0, width: 100, height: 100)
        XCTAssertTrue(r.x == 0)
        r.x = 100
        XCTAssertTrue(r.x == 100)
        XCTAssertTrue(r.y == 0)
        r.y = 100
        XCTAssertTrue(r.y == 100)
        var r1 = CGRect.oneByOne()
        XCTAssertTrue(r1.x == 0 && r1.y == 0 && r1.size.width == 1 && r1.size.height == 1)
        r1.width = 50
        r1.height = 60
        XCTAssertTrue(r1.x == 0 && r1.y == 0 && r1.size.width == 50 && r1.size.height == 60)

        let r2 = CGRect.none()
        XCTAssertTrue(r2.x == 0 && r2.y == 0 && r2.size.width == 0 && r2.size.height == 0)
        
        var rect3 = CGRect(x: 100, y: 50, width: 150, height: 200)
        XCTAssertTrue(rect3.top == 50)
        XCTAssertTrue(rect3.bottom == 250)
        XCTAssertTrue(rect3.right == 250)
        XCTAssertTrue(rect3.left == 100)
        
        rect3.top = 150
        XCTAssertTrue(rect3.top == 150)

        rect3.bottom = 150
        XCTAssertTrue(rect3.bottom == 150)
        
        rect3.right = 150
        XCTAssertTrue(rect3.right == 150)
        
        rect3.left = 150
        XCTAssertTrue(rect3.left == 150)
    }
    
    func testUIView() {
        let v1 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        XCTAssertTrue(v1.size.width == 10 && v1.size.height == 20)
        v1.size = CGSize(width: 20, height: 10)
        XCTAssertTrue(v1.size.width == 20 && v1.size.height == 10)

        
        
    }
    
    func testDictionary() {
        let dict: [String: Any] = ["a": "a", "b": "b"]
        guard let url = "a".asURLInDocumentDirectory() else {
            XCTAssert(false)
            return
        }
        XCTAssertTrue(dict.saveAsPlist(to: url))
    }
}
