//
//  AVAsset+STFramework.swift
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

extension AVAsset {
    
    // returns asset duration in seconds
    var durationInSeconds: Float {
        return Float(duration.value) / Float(duration.timescale)
    }
    
    // returns asset image size
    var imageSize: CGSize? {
        guard let firstTrack = tracks(withMediaType: AVMediaTypeVideo).first else {
            return nil
        }
        let imageSize = firstTrack.naturalSize.applying(firstTrack.preferredTransform)
        return CGSize(width: fabs(imageSize.width), height: fabs(imageSize.height))
    }
    
    // returns asset orientation
    var orientation: UIInterfaceOrientation? {
        guard let video = tracks(withMediaType: AVMediaTypeVideo).first else {
            return nil
        }
        let transform = video.preferredTransform
        if transform.a == 1 && transform.d == 1  {
            return .landscapeLeft
        } else if transform.a == -1 && transform.d == -1 {
            return .landscapeRight
        } else if transform.b == -1 && transform.c == 1 {
            return .portraitUpsideDown
        } else {
            return .portrait
        }
    }
    
}

extension URL {
    
    // returns duration in seconds of an AVAsset located at this URL
    var avAssetDurationInSeconds: Float {
        return AVAsset(url: self).durationInSeconds
    }
    
    // returns image size of an AVAsset located at this URL
    var avAssetImageSize: CGSize? {
        return AVAsset(url: self).imageSize
    }
    
    // returns orientation of an AVAsset located at this URL
    var avAssetOrientation: UIInterfaceOrientation? {
        return AVAsset(url: self).orientation
    }
    
}

