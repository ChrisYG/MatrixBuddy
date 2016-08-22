//
//  Computation.swift
//  MatrixBuddy
//
//  Created by Xiangyu Fu on 8/10/16.
//  Copyright © 2016 Balabala & Company. All rights reserved.
//

import Foundation
import UIKit

class Computation {
    
    var headOperation:String?
    var middleOperation:String?
    var firstMatrix:[[String]]?
    var secondMatrix:[[String]]?
    var result:[[String]]?
    
    init(headOperation:String?, middleOperation:String?, firstMatrix:[[String]]?, secondMatrix:[[String]]?, result:[[String]]?) {
        self.headOperation = headOperation
        self.middleOperation = middleOperation
        self.firstMatrix = firstMatrix
        self.secondMatrix = secondMatrix
        self.result = result
    }
}