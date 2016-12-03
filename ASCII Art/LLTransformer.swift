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
    func convertFinished(_ text: String)
}

class LLTransformer {
    
    var delegate: LLTransformerDelegate?
    
    ///
    /**
     
     Convert a UIImage to string
     
     - Parameters:
     - image: The UIImage which will be converted.
     - clarity: 0 < clarity < 100. The higher the number, the clearer the string picture.
     
     */
    func convertUIImageToText(image: UIImage, clarity: Int) -> String {
        var clarity = 100 - clarity
        
        if clarity <= 0 { clarity = 1 }
        
        let underNumOfWidth = clarity
        let underNumOfHeight = clarity * 2
        
        var stringValue = ""
        let cgimage = image.cgImage
        let imageWidth = cgimage?.width
        let imageHeight = cgimage?.height
        
        let pixelData = cgimage?.dataProvider?.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        for i in 0..<Int(imageHeight! / underNumOfHeight) {
            for j in 0..<Int(imageWidth! / underNumOfWidth) {
                var total = 0.0
                
                for x in j * underNumOfWidth..<j * underNumOfWidth + underNumOfWidth {
                    for y in i * underNumOfHeight..<i * underNumOfHeight + underNumOfHeight {
                        let pixelInfo = 4 * ((Int(imageWidth!) * Int(y)) + Int(x))
                        
                        let r = CGFloat(data[pixelInfo])
                        let g = CGFloat(data[pixelInfo + 1])
                        let b = CGFloat(data[pixelInfo + 2])
                        let average = (r + g + b) / 3
                        
                        total += Double(average)
                    }
                }
                
                let average = total / Double(underNumOfHeight * underNumOfWidth)
                
                switch average {
                case 245...255: stringValue += "."
                case 220..<245: stringValue += ":"
                case 180..<220: stringValue += "*"
                case 130..<180: stringValue += "I"
                case 100..<130: stringValue += "V"
                case 80..<100: stringValue += "F"
                case 50..<80: stringValue += "N"
                default: stringValue += "M"
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
