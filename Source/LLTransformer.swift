//
//  LLTransformer.swift
//  ASCII Art
//
//  Created by Liuliet.Lee on 25/6/2016.
//  Copyright © 2016 Liuliet.Lee. All rights reserved.
//

import Foundation
import UIKit

protocol LLTransformerDelegate {
    func convertFinished(text: String)
}

class LLTransformer {
    
    var delegate: LLTransformerDelegate?
    
    private func convertUIImageToCGImage(image: UIImage) -> CGImage {
        let ciimage = CIImage(image: image)!
        let context = CIContext(options: nil)
        let cgimage = context.createCGImage(ciimage, fromRect: ciimage.extent)
        return cgimage
    }
    
    ///
    /**
     
     Convert a UIImage to string
     
     - Parameters:
     - image: The UIImage which will be converted.
     - clarity: 0 < clarity < 100. The higher the number, the clearer the string picture.
     
     */
    func convertUIImageToText(image image: UIImage, clarity: Int) -> String {
        var clarity = 100 - clarity
        
        if clarity <= 0 { clarity = 1 }
        
        let underNumOfWidth = clarity
        let underNumOfHeight = clarity * 2
        
        var stringValue = ""
        let cgimage = convertUIImageToCGImage(image)
        let imageWidth = CGImageGetWidth(cgimage)
        let imageHeight = CGImageGetHeight(cgimage)
        
        let pixelData = CGDataProviderCopyData(CGImageGetDataProvider(cgimage))
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        for i in 0..<Int(imageHeight / underNumOfHeight) {
            for j in 0..<Int(imageWidth / underNumOfWidth) {
                var total = 0.0
                
                for x in j * underNumOfWidth..<j * underNumOfWidth + underNumOfWidth {
                    for y in i * underNumOfHeight..<i * underNumOfHeight + underNumOfHeight {
                        let pixelInfo = 4 * ((Int(imageWidth) * Int(y)) + Int(x))
                        
                        let r = CGFloat(data[pixelInfo])
                        let g = CGFloat(data[pixelInfo + 1])
                        let b = CGFloat(data[pixelInfo + 2])
                        let average = (r + g + b) / 3
                        
                        total += Double(average)
                    }
                }
                
                let average = total / Double(underNumOfHeight * underNumOfWidth)
                
                if average > 245 {
                    stringValue += "."
                } else if average > 220 {
                    stringValue += ":"
                } else if average > 180 {
                    stringValue += "*"
                } else if average > 130 {
                    stringValue += "I"
                } else if average > 100 {
                    stringValue += "V"
                } else if average > 80 {
                    stringValue += "F"
                } else if average > 50 {
                    stringValue += "N"
                } else {
                    stringValue += "M"
                }
            }
            stringValue += "\n"
        }
        
        if delegate != nil {
            delegate!.convertFinished(stringValue)
        }
        
        return stringValue
    }

}