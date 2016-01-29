//
//  Math.swift
//  JingJianLogistics-iOS
//
//  Created by Jason Raylegih on 22/9/15.
//  Copyright (c) 2015 Jason Raylegih. All rights reserved.
//

import Foundation

class MathUtil {
    
    static let PI: Float = 3.1415
    
    //MARK: - SUM
    class func sum(integer numbers: Int...) -> Int {
        var theSum: Int = 0
        if numbers.count > 0 {
            for i in numbers {
                theSum += i
            }
        } else {
            theSum = numbers[0]
        }
        return theSum
    }
    
    class func sum(double numbers: Float...) -> Float {
        var theSum: Float = 0
        if numbers.count > 0 {
            for i in numbers {
                theSum += i
            }
        } else {
            theSum = numbers[0]
        }
        return theSum
    }
    
    class func sum(integer numbers: [Int]) -> Int {
        var theSum: Int = 0
        if numbers.count > 0 {
            for i in numbers {
                theSum += i
            }
        } else {
            theSum = numbers[0]
        }
        return theSum
    }
    
    class func sum(double numbers: [Float]) -> Float {
        var theSum: Float = 0
        if numbers.count > 0 {
            for i in numbers {
                theSum += i
            }
        } else {
            theSum = numbers[0]
        }
        return theSum
    }
    
    //MARK: - Average
    class func avg(numbers: Int...) -> Int {
        return Int(MathUtil.sum(integer: numbers) / numbers.count)
    }
    
    class func avg(numbers: Float...) -> Float {
        return Float(MathUtil.sum(double: numbers) / Float(numbers.count))
    }
    
    class func avg(numbers: [Int]) -> Int {
        return Int(MathUtil.sum(integer: numbers) / numbers.count)
    }
    
    class func avg(numbers: [Float]) -> Float {
        return Float(MathUtil.sum(double: numbers) / Float(numbers.count))
    }
    
    //MARK: - Perimeter
    class func perimeter(length: Int, andWidth width: Int) -> Float {
        return Float((length + width) * 2)
    }
    class func perimeter(length: Float, andWidth width: Float) -> Float {
        return Float((length + width) * 2)
    }
    class func perimeter(firstSideLength side1: Int, secondSideLength side2: Int, thirdSideLength side3: Int) -> Float {
        return Float(side1 + side2 + side3)
    }
    class func perimeter(firstSideLength side1: Float, secondSideLength side2: Float, thirdSideLength side3: Float) -> Float {
        return Float(side1 + side2 + side3)
    }
    class func perimeter(radius: Int) -> Float {
        return Float(2) * MathUtil.PI * Float(radius)
    }
    class func perimeter(radius: Float) -> Float {
        return Float(2) * MathUtil.PI * radius
    }
    
    //MARK: - Area
    class func area(length: Int, andWidth width: Int) -> Float {
        return Float(length * width)
    }
    class func area(length: Float, andWidth width: Float) -> Float {
        return Float(length * width)
    }
    class func area(width: Int, andHeight height: Int) -> Float {
        return Float(0.5 * Float(width * height))
    }
    class func area(width: Float, andHeight height: Float) -> Float {
        return Float(0.5 * (width * height))
    }
    class func area(radius: Int) -> Float {
        return MathUtil.PI * Float(radius * radius)
    }
    class func area(radius: Float) -> Float {
        return MathUtil.PI * (radius * radius)
    }
}