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
    var verticalIndexOne:Int
    var horizontalIndexOne:Int
    var verticalIndexTwo:Int?
    var horizontalIndexTwo:Int?
    
    init(inMatrixOne:Bool, verticalIndex:Int, horizontalIndex:Int) {
        self.inMatrixOne = inMatrixOne
        self.verticalIndexOne = verticalIndex
        self.horizontalIndexOne = horizontalIndex
    }
    
    func moveUp(){
        if self.inMatrixOne == true {
            self.verticalIndexOne -= 1
        } else {
            self.verticalIndexTwo! -= 1
        }
    }
    
    func moveDown(){
        if self.inMatrixOne == true {
            self.verticalIndexOne += 1
        } else {
            self.verticalIndexTwo! += 1
        }
    }
    
    func moveLeft(){
        if self.inMatrixOne == true {
            self.horizontalIndexOne -= 1
        } else {
            self.horizontalIndexTwo! -= 1
        }
    }
    
    func moveRight(){
        if self.inMatrixOne == true {
            self.horizontalIndexOne += 1
        } else {
            self.horizontalIndexTwo! += 1
        }
    }
    
    func moveToSecondMatirx(){
        self.inMatrixOne = false
        
    }
    
    func moveToFirstMatrix(){
        self.inMatrixOne = true
        
    }
    
    func reset(){
        if self.inMatrixOne == true {
            self.horizontalIndexOne = 0
            self.verticalIndexTwo = 0
        } else {
            self.horizontalIndexTwo = 0
            self.horizontalIndexOne = 0
        }
    }
    
    func resetAll() {
        self.inMatrixOne = true
        self.horizontalIndexOne = 0
        self.horizontalIndexTwo = 0
        self.verticalIndexOne = 0
        self.verticalIndexTwo = 0
    }
}
