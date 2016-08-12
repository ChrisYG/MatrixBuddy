//
//  EditCursor.swift
//  MatrixBuddy
//
//  Created by Xiangyu Fu on 8/11/16.
//  Copyright © 2016 Balabala & Company. All rights reserved.
//

import Foundation
import UIKit

class EditCursor {
    var inMatrixOne:Bool
    var verticalIndex:Int
    var horizontalIndex:Int
    var firstMatrixLength:Int = 0
    
    init(inMatrixOne:Bool, verticalIndex:Int, horizontalIndex:Int) {
        self.inMatrixOne = inMatrixOne
        self.verticalIndex = verticalIndex
        self.horizontalIndex = horizontalIndex
    }
    
    func moveUp(){
        self.verticalIndex += 1
    }
    
    func moveDown(){
        self.verticalIndex -= 1
        
    }
    
    func moveLeft(){
        self.horizontalIndex -= 1
    }
    
    func moveRight(){
        self.horizontalIndex += 1
    }
    
    func moveToSecondMatirx(){
        self.inMatrixOne = false
        self.firstMatrixLength = self.horizontalIndex
        self.horizontalIndex = 0
    }
    
    func moveToFirstMatrix(){
        self.inMatrixOne = true
        self.horizontalIndex = self.firstMatrixLength
    }
    
    func reset(){
        self.inMatrixOne = true
        self.verticalIndex = 0
        self.horizontalIndex = 0
    }
}
