//
//  AVAssetExportSession+STFramework.swift
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
import AVFoundation

extension AVAssetExportSession {
    
    // trims a video if its duration exceeds
    @discardableResult
    static func trimVideo(sourceURL: URL, destinationURL: URL, maxDuration: Float, finished: @escaping (_ success: Bool) -> Void) -> AVAssetExportSession? {
        return trimVideo(sourceURL: sourceURL, destinationURL: destinationURL, startTime: 0, endTime: maxDuration, finished: finished)
    }
    
    // trims a video
    @discardableResult
    static func trimVideo(sourceURL: URL, destinationURL: URL, startTime: Float, endTime: Float, outputFileType: String? = AVFileTypeMPEG4, finished: @escaping (_ success: Bool) -> Void) -> AVAssetExportSession? {
        guard FileManager.fileExists(at: sourceURL) else {
            finished(false)
            return nil
        }
        let asset = AVAsset(url: sourceURL)
        FileManager.removeItem(at: destinationURL)
        
        guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality), startTime < endTime, endTime < asset.durationInSeconds else {
            finished(false)
            return nil
        }
        exportSession.outputURL = destinationURL
        if let outputFileType = outputFileType {
            exportSession.outputFileType = outputFileType
        }
        
        let timeRangeStartTime = CMTime(seconds: Double(startTime), preferredTimescale: 1000)
        let timeRangeEndTime = CMTime(seconds: Double(endTime), preferredTimescale: 1000)
        exportSession.timeRange = CMTimeRange(start: timeRangeStartTime, end: timeRangeEndTime)
        exportSession.exportAsynchronously {
            switch exportSession.status {
            case .completed:
                finished(true)
            default:
                finished(false)
            }
        }
        return exportSession
    }
}
