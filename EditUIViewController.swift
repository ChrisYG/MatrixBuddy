//
//  EditUIViewController.swift
//  MatrixBuddy
//
//  Created by Xiangyu Fu on 8/11/16.
//  Copyright © 2016 Balabala & Company. All rights reserved.
//

import UIKit

class EditUIViewController: UIViewController {
    
    var computation:Computation?
    var cursor:EditCursor = EditCursor(inMatrixOne: true, verticalIndex: 0, horizontalIndex: 0)
    
    //Row and Col labels and steppers reference
    @IBOutlet weak var matrixOneRowLabel: UILabel!
    @IBOutlet weak var matrixOneColLabel: UILabel!
    @IBOutlet weak var matrixTwoRowLabel: UILabel!
    @IBOutlet weak var matrixTwoColLabel: UILabel!
    
    @IBOutlet weak var matrixOneRowStepper: UIStepper!
    @IBOutlet weak var matrixOneColStepper: UIStepper!
    @IBOutlet weak var matrixTwoRowStepper: UIStepper!
    @IBOutlet weak var matrixTwoColStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cursor.reset()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Direction buttons
    @IBAction func cursorUp(sender: UIButton) {
        if cursor.verticalIndex > 0 {
            cursor.moveUp()
        }
    }
    
    @IBAction func cursorDown(sender: UIButton) {
        if cursor.inMatrixOne == true {
            if cursor.verticalIndex < (computation?.firstMatrix.count)! - 1 {
                cursor.moveDown()
            }
        } else {
            if cursor.verticalIndex < (computation?.secondMatrix!.count)! - 1 {
                cursor.moveDown()
            }
        }
    }
    
    @IBAction func cursorLeft(sender: UIButton) {
        if cursor.inMatrixOne == true {
            if cursor.horizontalIndex > 0 {
                cursor.moveLeft()
            }
        } else {
            if cursor.horizontalIndex > 0 {
                cursor.moveLeft()
            } else if cursor.verticalIndex <= (computation?.firstMatrix.count)! - 1 {
                cursor.moveToFirstMatrix()
            }
        }

    }
    
    @IBAction func cursorRight(sender: UIButton) {
        if cursor.inMatrixOne == false {
            cursor.moveRight()
        } else {
            if cursor.horizontalIndex < (computation?.firstMatrix[0].count)! - 1 {
                cursor.moveRight()
            } else if cursor.horizontalIndex == (computation?.firstMatrix[0].count)! - 1 {
                if cursor.verticalIndex <= (computation?.secondMatrix!.count)! - 1 {
                    cursor.moveToSecondMatirx()
                }
            }
        }

    }


    
    //Reset button
    @IBAction func resetBoard(sender: UIButton) {
        computation?.firstMatrix = [
            ["0","0","0"],
            ["0","0","0"],
            ["0","0","0"]
        ]
        matrixOneColLabel.text = "Col: 3"
        matrixOneRowLabel.text = "Row: 3"
        matrixOneColStepper.value = 3
        matrixOneRowStepper.value = 3
        
        if computation?.secondMatrix != nil {
            computation?.secondMatrix = [
                ["0","0","0"],
                ["0","0","0"],
                ["0","0","0"]
            ]
            matrixTwoColLabel.text = "Col: 3"
            matrixTwoRowLabel.text = "Row: 3"
            matrixTwoColStepper.value = 3
            matrixTwoRowStepper.value = 3
        }
        cursor.reset()
    }
    
    //Steppers action
    @IBAction func changeMatrixOneRow(sender: UIStepper) {
        matrixOneRowLabel.text = "Row: " + String(Int(matrixOneRowStepper.value))
    }
    @IBAction func changeMatrixOneCol(sender: UIStepper) {
        matrixOneColLabel.text = "Col: " + String(Int(matrixOneColStepper.value))
    }
    @IBAction func changeMatrixTwoRow(sender: UIStepper) {
        matrixTwoRowLabel.text = "Row: " + String(Int(matrixTwoRowStepper.value))
    }
    @IBAction func changeMatrixTwoCol(sender: UIStepper) {
        matrixTwoColLabel.text = "Col " + String(Int(matrixTwoColStepper.value))
    }

}
