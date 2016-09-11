//
//  EditUIViewController.swift
//  MatrixBuddy
//
//  Created by Xiangyu Fu on 8/11/16.
//  Copyright © 2016 Balabala & Company. All rights reserved.
//

import UIKit

class EditUIViewController: UIViewController {
    var computation = Computation(headOperation: nil, middleOperation: nil, firstMatrix: nil,secondMatrix: nil, result: nil)
    
    var cursor:EditCursor = EditCursor(inMatrixOne: true, verticalIndex: 0, horizontalIndex: 0)
    
    // Matrix row display references
    
    @IBOutlet weak var row1: UILabel!
    @IBOutlet weak var row2: UILabel!
    @IBOutlet weak var row3: UILabel!
    @IBOutlet weak var row4: UILabel!
    @IBOutlet weak var row5: UILabel!
    
    //Row and Col labels and steppers reference
    @IBOutlet weak var rowLabel: UILabel!
    @IBOutlet weak var colLabel: UILabel!
    
    @IBOutlet weak var rowStepper: UIStepper!
    @IBOutlet weak var colStepper: UIStepper!
    
    //save navigation button and page control references
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //button references
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var fractionButton: UIButton!
    @IBOutlet weak var decimalButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var negativeSignButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var stepperView: UIView!
    
    @IBOutlet weak var matrixABLabel: UILabel!
    @IBOutlet weak var editView: UIView!
    
    //references to swipe gesture recognizers
    @IBOutlet var rightSwipeRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var leftSwipeRecognizer: UISwipeGestureRecognizer!
    
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    // A helper function for alignment
    func findLongestStrLenInEachCol(matrix: [[String]]) -> [Int] {
        var longestStringLengthInEachColumn: [Int] = []
        for col in 0...matrix[0].count-1 {
            var maxLength = matrix[0][col].characters.count
            for row in 0...matrix.count-1 {
                let tempCount = matrix[row][col].characters.count
                if tempCount > maxLength {
                    maxLength = tempCount
                }
            }
            longestStringLengthInEachColumn.append(maxLength)
        }
        return longestStringLengthInEachColumn
    }
    
    // A helper function for delegate functoin
    func convertMatrixToLabelArray(matrix: [[String]]) -> [UILabel] {
        var matrixLabels: [UILabel] = []
        var longestStringLengthInEachColumn =
            findLongestStrLenInEachCol(matrix)
        
        // Setting each row of the matrix as UILabel
        for row in 0...matrix.count-1 {
            let newLabel: UILabel = UILabel.init()
            var rowString = ""
            for col in 0...matrix[row].count-1 {
                rowString.appendContentsOf(matrix[row][col])
                if col != matrix[row].count - 1 {
                    // adding spacing offsets
                    for _ in 0...longestStringLengthInEachColumn[col]-matrix[row][col].characters.count {
                        rowString.appendContentsOf(" ")
                    }
                }
            }
            newLabel.text = rowString
            matrixLabels.append(newLabel)
        }
        return matrixLabels
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(computation.firstMatrix)
        // Do any additional setup after loading the view, typically from a nib.
        
        //Setting up matrix
        let labels = convertMatrixToLabelArray(computation.firstMatrix!)
        let rows = [row1, row2, row3, row4, row5]
        for i in 0...labels.count-1 {
            rows[i].text = labels[i].text
        }
        // Problematic?
        for i in labels.count...4 {
            rows[i].text = ""
        }
        
        cursor.resetAll()
        if computation.secondMatrix == nil {
            pageControl.numberOfPages = 1
        }
        rowLabel.text = "Row: " + String(computation.firstMatrix!.count)
        rowStepper.value = Double(computation.firstMatrix!.count)
        colLabel.text = "Col: " + String(computation.firstMatrix![0].count)
        colStepper.value = Double(computation.firstMatrix![0].count)
        
        //set borders of buttons
        zeroButton.layer.borderWidth = 0.5
        zeroButton.layer.borderColor = UIColor.blackColor().CGColor
        oneButton.layer.borderWidth = 0.5
        oneButton.layer.borderColor = UIColor.blackColor().CGColor
        twoButton.layer.borderWidth = 0.5
        twoButton.layer.borderColor = UIColor.blackColor().CGColor
        threeButton.layer.borderWidth = 0.5
        threeButton.layer.borderColor = UIColor.blackColor().CGColor
        fourButton.layer.borderWidth = 0.5
        fourButton.layer.borderColor = UIColor.blackColor().CGColor
        fiveButton.layer.borderWidth = 0.5
        fiveButton.layer.borderColor = UIColor.blackColor().CGColor
        sixButton.layer.borderWidth = 0.5
        sixButton.layer.borderColor = UIColor.blackColor().CGColor
        sevenButton.layer.borderWidth = 0.5
        sevenButton.layer.borderColor = UIColor.blackColor().CGColor
        eightButton.layer.borderWidth = 0.5
        eightButton.layer.borderColor = UIColor.blackColor().CGColor
        nineButton.layer.borderWidth = 0.5
        nineButton.layer.borderColor = UIColor.blackColor().CGColor
        fractionButton.layer.borderWidth = 0.5
        fractionButton.layer.borderColor = UIColor.blackColor().CGColor
        decimalButton.layer.borderWidth = 0.5
        decimalButton.layer.borderColor = UIColor.blackColor().CGColor
        negativeSignButton.layer.borderWidth = 0.5
        negativeSignButton.layer.borderColor = UIColor.blackColor().CGColor
        resetButton.layer.borderWidth = 0.5
        resetButton.layer.borderColor = UIColor.blackColor().CGColor
        deleteButton.layer.borderWidth = 0.5
        deleteButton.layer.borderColor = UIColor.blackColor().CGColor
        upButton.layer.borderWidth = 0.5
        upButton.layer.borderColor = UIColor.blackColor().CGColor
        downButton.layer.borderWidth = 0.5
        downButton.layer.borderColor = UIColor.blackColor().CGColor
        leftButton.layer.borderWidth = 0.5
        leftButton.layer.borderColor = UIColor.blackColor().CGColor
        rightButton.layer.borderWidth = 0.5
        rightButton.layer.borderColor = UIColor.blackColor().CGColor
        stepperView.layer.borderWidth = 0.5
        stepperView.layer.borderColor = UIColor.blackColor().CGColor
        
        leftSwipeRecognizer.direction = .Left
        rightSwipeRecognizer.direction = .Right
        leftSwipeRecognizer.addTarget(editView, action: Selector("handleSwipes:"))
        rightSwipeRecognizer.addTarget(editView, action: Selector("handleSwipes:"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if sender.direction == .Left {
            print("swipe left")
        } else {
            print("swipe right")
        }
    }
    @IBAction func changePage(sender: UIPageControl) {
        if pageControl.currentPage == 1 {
            cursor.inMatrixOne = false
            rowLabel.text = "Row: " + String(computation.secondMatrix!.count)
            rowStepper.value = Double(computation.secondMatrix!.count)
            colLabel.text = "Col: " + String(computation.secondMatrix![0].count)
            colStepper.value = Double(computation.secondMatrix![0].count)
            matrixABLabel.text = "Matrix B"
            if computation.middleOperation == "x scalar" {
                rowStepper.enabled = false
                colStepper.enabled = false
                matrixABLabel.text = "Scalar"
            }
        } else {
            rowStepper.enabled = true
            colStepper.enabled = true
            cursor.inMatrixOne = true
            rowLabel.text = "Row: " + String(computation.firstMatrix!.count)
            rowStepper.value = Double(computation.firstMatrix!.count)
            colLabel.text = "Col: " + String(computation.firstMatrix![0].count)
            colStepper.value = Double(computation.firstMatrix![0].count)
            matrixABLabel.text = "Matrix A"
        }
    }
    //Direction buttons
    @IBAction func cursorUp(sender: UIButton) {
        if cursor.inMatrixOne == true {
            if cursor.verticalIndexOne > 0 {
                cursor.moveUp()
                print(cursor.inMatrixOne)
                print(cursor.horizontalIndexOne)
                print(cursor.verticalIndexOne)
            }
        } else {
            if cursor.verticalIndexTwo > 0 {
                cursor.moveUp()
                print(cursor.inMatrixOne)
                print(cursor.horizontalIndexTwo)
                print(cursor.verticalIndexTwo)
            }
        }
        
    }
    
    
    @IBAction func cursorDown(sender: UIButton) {
        if cursor.inMatrixOne == true {
            if cursor.verticalIndexOne < (computation.firstMatrix!.count) - 1 {
                cursor.moveDown()
                print(cursor.inMatrixOne)
                print(cursor.horizontalIndexOne)
                print(cursor.verticalIndexOne)
            }
        } else {
            if cursor.verticalIndexTwo < (computation.secondMatrix!.count) - 1 {
                cursor.moveDown()
                print(cursor.inMatrixOne)
                print(cursor.horizontalIndexTwo)
                print(cursor.verticalIndexTwo)
            }
        }
        
    }
    
    @IBAction func cursorLeft(sender: UIButton) {
        if cursor.inMatrixOne == true {
            if cursor.horizontalIndexOne > 0 {
                cursor.moveLeft()
                print(cursor.inMatrixOne)
                print(cursor.horizontalIndexOne)
                print(cursor.verticalIndexOne)
            }
        } else {
            if cursor.horizontalIndexTwo > 0 {
                cursor.moveLeft()
                print(cursor.inMatrixOne)
                print(cursor.horizontalIndexTwo)
                print(cursor.verticalIndexTwo)
            }
        }
        
    }

    
    @IBAction func cursorRight(sender: UIButton) {
        if cursor.inMatrixOne == false {
            if cursor.horizontalIndexTwo < computation.secondMatrix![0].count - 1 {
                cursor.moveRight()
                print(cursor.inMatrixOne)
                print(cursor.horizontalIndexTwo)
                print(cursor.verticalIndexTwo)
            }
        } else {
            if cursor.horizontalIndexOne < (computation.firstMatrix![0].count) - 1 {
                cursor.moveRight()
                print(cursor.inMatrixOne)
                print(cursor.horizontalIndexOne)
                print(cursor.verticalIndexOne)
            }
        }
        
    }

    //Reset button
    @IBAction func pressReset(sender: UIButton) {
        if cursor.inMatrixOne == true {
            computation.firstMatrix = [
                ["0","0","0"],
                ["0","0","0"],
                ["0","0","0"]
            ]
            colLabel.text = "Col: 3"
            rowLabel.text = "Row: 3"
            colStepper.value = 3
            rowStepper.value = 3
        } else {
            if computation.secondMatrix != nil {
                computation.secondMatrix = [
                    ["0","0","0"],
                    ["0","0","0"],
                    ["0","0","0"]
                ]
                colLabel.text = "Col: 3"
                rowLabel.text = "Row: 3"
                colStepper.value = 3
                rowStepper.value = 3
            }
        }
        cursor.reset()
    }
    
    
    //steppers action
    @IBAction func changeRow(sender: UIStepper) {
        rowLabel.text = "Row: " + String(Int(rowStepper.value))
        if cursor.inMatrixOne == true {
            if Int(rowStepper.value) > computation.firstMatrix!.count {
                print("add Row")
                computation.firstMatrix = addRow(computation.firstMatrix!)
                print(computation.firstMatrix)
            } else if Int(rowStepper.value) < computation.firstMatrix!.count {
                print("remove Row")
                if cursor.verticalIndexOne == computation.firstMatrix!.count - 1 {
                    cursor.moveUp()
                }
                computation.firstMatrix = removeRow(computation.firstMatrix!)
                print(computation.firstMatrix)
            }
        } else {
            if Int(rowStepper.value) > computation.secondMatrix!.count {
                print("add Row")
                computation.secondMatrix = addRow(computation.secondMatrix!)
                print(computation.secondMatrix)
            } else if Int(rowStepper.value) < computation.secondMatrix!.count {
                print("remove Row")
                if cursor.verticalIndexTwo == computation.secondMatrix!.count - 1 {
                    cursor.moveUp()
                }
                computation.secondMatrix = removeRow(computation.secondMatrix!)
                print(computation.secondMatrix)
            }
        }
    }
    @IBAction func changeCol(sender: UIStepper) {
        colLabel.text = "Col: " + String(Int(colStepper.value))
        if cursor.inMatrixOne == true {
            if Int(colStepper.value) > computation.firstMatrix![0].count {
                print("add Row")
                computation.firstMatrix = addCol(computation.firstMatrix!)
                print(computation.firstMatrix)
            } else if Int(colStepper.value) < computation.firstMatrix![0].count {
                print("remove Row")
                if cursor.horizontalIndexOne == computation.firstMatrix![0].count - 1 {
                    cursor.moveLeft()
                }
                computation.firstMatrix = removeCol(computation.firstMatrix!)
                print(computation.firstMatrix)
            }
        } else {
            if Int(colStepper.value) > computation.secondMatrix![0].count {
                print("add Row")
                computation.secondMatrix = addCol(computation.secondMatrix!)
                print(computation.secondMatrix)
            } else if Int(rowStepper.value) < computation.secondMatrix![0].count {
                print("remove Row")
                if cursor.horizontalIndexTwo == computation.secondMatrix![0].count - 1 {
                    cursor.moveLeft()
                }
                computation.secondMatrix = removeCol(computation.secondMatrix!)
                print(computation.secondMatrix)
            }
        }
    }
        
    //0-9 number buttons
    @IBAction func pressZero(sender: UIButton) {
        if cursor.inMatrixOne == true {
            let target = computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne]
            if target != "0" && (!(target.hasSuffix("/"))){
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] += "0"
            }
            print(computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne])
        } else {
            let target = computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!]
            if target != "0" && (!(target.hasSuffix("/"))){
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] += "0"
            }
            print(computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!])
        }
    }
    @IBAction func pressOne(sender: UIButton) {
        if cursor.inMatrixOne == true {
            if computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] == "0" {
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] = "1"
            } else {
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] += "1"
            }
            print(computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne])
        } else {
            if computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] == "0" {
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] = "1"
            } else {
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] += "1"
            }
            print(computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!])
        }
    }
    @IBAction func pressTwo(sender: UIButton) {
        if cursor.inMatrixOne == true {
            if computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] == "0" {
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] = "2"
            } else {
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] += "2"
            }
            print(computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne])
        } else {
            if computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] == "0" {
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] = "2"
            } else {
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] += "2"
            }
            print(computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!])
        }
    }
    @IBAction func pressThree(sender: UIButton) {
        if cursor.inMatrixOne == true {
            if computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] == "0" {
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] = "3"
            } else {
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] += "3"
            }
            print(computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne])
        } else {
            if computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] == "0" {
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] = "3"
            } else {
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] += "3"
            }
            print(computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!])
        }
    }
    @IBAction func pressFour(sender: UIButton) {
        if cursor.inMatrixOne == true {
            if computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] == "0" {
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] = "4"
            } else {
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] += "4"
            }
            print(computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne])
        } else {
            if computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] == "0" {
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] = "4"
            } else {
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] += "4"
            }
            print(computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!])
        }
    }
    @IBAction func pressFive(sender: UIButton) {
        if cursor.inMatrixOne == true {
            if computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] == "0" {
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] = "5"
            } else {
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] += "5"
            }
            print(computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne])
        } else {
            if computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] == "0" {
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] = "5"
            } else {
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] += "5"
            }
            print(computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!])
        }
    }
    @IBAction func pressSix(sender: UIButton) {
        if cursor.inMatrixOne == true {
            if computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] == "0" {
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] = "6"
            } else {
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] += "6"
            }
            print(computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne])
        } else {
            if computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] == "0" {
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] = "6"
            } else {
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] += "6"
            }
            print(computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!])
        }
    }
    @IBAction func pressSeven(sender: UIButton) {
        if cursor.inMatrixOne == true {
            if computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] == "0" {
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] = "7"
            } else {
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] += "7"
            }
            print(computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne])
        } else {
            if computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] == "0" {
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] = "7"
            } else {
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] += "7"
            }
            print(computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!])
        }
    }
    @IBAction func pressEight(sender: UIButton) {
        if cursor.inMatrixOne == true {
            if computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] == "0" {
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] = "8"
            } else {
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] += "8"
            }
            print(computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne])
        } else {
            if computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] == "0" {
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] = "8"
            } else {
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] += "8"
            }
            print(computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!])
        }
    }
    @IBAction func pressNine(sender: UIButton) {
        if cursor.inMatrixOne == true {
            if computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] == "0" {
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] = "9"
            } else {
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] += "9"
            }
            print(computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne])
        } else {
            if computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] == "0" {
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] = "9"
            } else {
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] += "9"
            }
            print(computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!])
        }
    }
    
    //negative sign button
    @IBAction func pressNegative(sender: UIButton) {
        if cursor.inMatrixOne == true {
            let target = computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne]
            if target == "0" {
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] = "-"
            } else {
                if target.characters.contains("-") {
                    computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] = target.substringFromIndex(target.startIndex.advancedBy(1))
                } else {
                    computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] = "-" + target
                }
            }
            print(computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne])
        } else {
            let target = computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!]
            if target == "0" {
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] = "-"
            } else {
                if target.characters.contains("-") {
                    computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] = target.substringFromIndex(target.startIndex.advancedBy(1))
                } else {
                    computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] = "-" + target
                }
            }
            print(computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!])
            
        }

    }
    
    //decimal sign button
    @IBAction func pressDecimal(sender: UIButton) {
        if cursor.inMatrixOne == true {
            let target = computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne]
            if !(target.characters.contains("/") || target.characters.contains(".")){
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] +=  "."
            }
            print(computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne])
        } else {
            let target = computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!]
            if !(target.characters.contains("/") || target.characters.contains(".")){
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] += "."
            }
            print(computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!])
        }
    }
    
    //fraction sign button
    @IBAction func pressFractionSign(sender: UIButton) {
        if cursor.inMatrixOne == true {
            let target = computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne]
            if !(target == "0" || target.characters.contains("/") || target.characters.contains(".")) {
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] += "/"
            }
            print(computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne])
        } else {
            let target = computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!]
            if !(target == "0" || target.characters.contains("/") || target.characters.contains(".")) {
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] += "/"
            }
            print(computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!])
        }

    }
    
    //delete button
    @IBAction func pressDelete(sender: UIButton) {
        if cursor.inMatrixOne == true {
            let target = computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne]
            if target.characters.count > 1{
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] = target.substringToIndex(target.endIndex.advancedBy(-1))
            } else if target != "0" {
                computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne] = "0"
            }
            print(computation.firstMatrix![cursor.verticalIndexOne][cursor.horizontalIndexOne])
        } else {
            let target = computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!]
            if target.characters.count > 1{
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] = target.substringToIndex(target.endIndex.advancedBy(-1))
            } else if target != "0" {
                computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!] = "0"
            }
            print(computation.secondMatrix![cursor.verticalIndexTwo!][cursor.horizontalIndexTwo!])
        }

    }
    

}






























