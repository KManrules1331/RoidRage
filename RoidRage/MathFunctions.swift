//
//  MathFunctions.swift
//  RoidRage
//
//  Created by igmstudent on 11/21/15.
//  Copyright © 2015 Alpaca. All rights reserved.
//

import Foundation
import SpriteKit

class Math
{
    class func randomCGFloat() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF);
    }
    
    class func randomCGFloat(min: CGFloat, max: CGFloat) -> CGFloat {
        return randomCGFloat() * (max - min) + min;
    }
    
    class func randomScalar() -> Scalar {
        return Scalar(Float(arc4random()) / 0xFFFFFFFF);
    }
    
    class func randomScalar(min: Scalar, max: Scalar) -> Scalar {
        return randomScalar() * (max - min) + min;
    }
}

//Conversion functions
extension CGPoint {
    init(_ vec2: Vector2) {
        self.x = CGFloat(vec2.x);
        self.y = CGFloat(vec2.y);
    }
}

extension Vector2 {
    init(_ point: CGPoint)
    {
        self.x = Scalar(point.x);
        self.y = Scalar(point.y);
    }
}

extension CGVector {
    init(_ vec: Vector2) {
        self.dx = CGFloat(vec.x);
        self.dy = CGFloat(vec.y);
    }
}