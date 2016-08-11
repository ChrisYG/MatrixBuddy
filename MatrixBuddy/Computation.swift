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
    var firstMatrix:[[String]]
    var secondMatrix:[[String]]?
    var matrixResult:[[String]]?
    var numberResult:Double?
    
    init(headOperation:String?, middleOperation:String?, firstMatrix:[[String]], secondMatrix:[[String]], matrixResult:[[String]]?, numberResult:Double?) {
        self.headOperation = headOperation
        self.middleOperation = middleOperation
        self.firstMatrix = firstMatrix
        self.secondMatrix = secondMatrix
        self.matrixResult = matrixResult
        self.numberResult = numberResult
    }
}