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
    var firstMatrix:[[Fraction]]
    var secondMatrix:[[Fraction]]?
    var matrixResult:[[Fraction]]?
    var numberResult:Double?
    
    init(headOperation:String?, middleOperation:String?, firstMatrix:[[Fraction]], secondMatrix:[[Fraction]], matrixResult:[[Fraction]]?, numberResult:Double?) {
        self.headOperation = headOperation
        self.middleOperation = middleOperation
        self.firstMatrix = firstMatrix
        self.secondMatrix = secondMatrix
        self.matrixResult = matrixResult
        self.numberResult = numberResult
    }
}