//
//  PhysicsCategory.swift
//  RoidRage
//
//  Created by igmstudent on 11/20/15.
//  Copyright © 2015 Alpaca. All rights reserved.
//

import Foundation

struct PhysicsCategory {
    static let None : UInt32 = 0;
    static let All : UInt32 = UInt32.max;
    
    static let Planet : UInt32      =   0x1;
    static let Asteroid : UInt32    =   0x1 << 1;
    static let Projectile : UInt32  =   0x1 << 2;
}