//
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
}
