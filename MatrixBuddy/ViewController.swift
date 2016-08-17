//
//  ViewController.swift
//  MatrixBuddy
//
//  Created by Xiangyu Fu on 8/5/16.
//  Copyright © 2016 Balabala & Company. All rights reserved.
//

import UIKit
import Darwin

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return computations.count
    }
    
    func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell",
                                                                         forIndexPath: indexPath)
        
        //cell.backgroundColor = computations[collectionView.tag][indexPath.item]
        
        return cell
    }
}

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.registerClass(MatrixTableViewCell.self, forCellReuseIdentifier: "matrixCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Configure it somewhere later
    var computations:[Computation] = []

    
    func tableView(tableView: UITableView,
                     cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("matrixCell", forIndexPath:indexPath)
        // Configure the cell based on computation variable
        let compVar:Computation = computations[indexPath.row]
        if let matrixCell = cell as? MatrixTableViewCell {
            matrixCell.firstOp.text = compVar.headOperation
            matrixCell.secondOp.text = compVar.middleOperation
            var matrixRows: [UILabel] = []
            // Setting each row of the matrix as UILabel
            for row in 0...compVar.firstMatrix.count {
                let newRow: UILabel = UILabel.init()
                var rowString = ""
                for col in 0...compVar.firstMatrix[row].count {
                    rowString.appendContentsOf(compVar.firstMatrix[row][col])
                    if col != compVar.firstMatrix[row].count - 1 {
                        rowString.appendContentsOf(" ")
                    }
                }
                newRow.text = rowString
                matrixRows.append(newRow)
            }
            matrixCell.firstMatrix = UIStackView.init(arrangedSubviews: matrixRows)
        }
        // TODO: 2nd and 3rd matrices
        
        return cell
    }
    
    func tableView(tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return computations.count
    }
    
    
    
}


//0.Equal Fraction matrices
func equalFractionMatrix(matrix1:[[Fraction]], matrix2:[[Fraction]]) -> Bool {
    if matrix1.count != matrix2.count || matrix1[0].count != matrix2[0].count {
        return false
    } else {
        for x in 0..<matrix1.count {
            for y in 0..<matrix1[0].count {
                if matrix1[x][y].numerator/matrix1[x][y].denominator != matrix2[x][y].numerator/matrix2[x][y].denominator {
                    return false
                }
            }
        }
        return true
    }
}

//0.1 Fraction convert to number
func fractionToNumber(input:Fraction) -> Double {
    return Double(input.numerator)/Double(input.denominator)
}

//0.5 Reduce entries
func reduceEntry(matrix:[[Fraction]]) -> [[Fraction]] {
    var result:[[Fraction]] = matrix
    for x in 0..<result.count {
        for y in 0..<result[0].count {
            let (numerator, denominator) = reduce(numerator: result[x][y].numerator, denominator: result[x][y].denominator)
            result[x][y] = Fraction(numerator:numerator,denominator:denominator)
        }
    }
    return result
}

//0.6 Convert fraction matrix to decimal matrix
func toDecimalMatrix(matrix:[[Fraction]]) -> [[Double]] {
    var result:[[Double]] = []
    var temp:[Double] = []
    var holder:Double = 0
    for x in 0..<matrix.count {
        for y in 0..<matrix[0].count {
            holder = Double(round(1000*Double(matrix[x][y].numerator)/Double(matrix[x][y].denominator))/1000)
            temp.append(holder)
        }
        result.append(temp)
        temp = []
    }
    return result
}

//0.7 Convert a raw Fraction to String representation
func toString(input: Fraction) -> String {
    guard !input.isNaN else { return "NaN" }
    guard !input.isInfinite else { return (input >= 0 ? "+" : "-") + "Inf" }
    switch input.denominator {
    case 1: return "\(input.numerator)"
    default: return "\(input.numerator)/\(input.denominator)"
    }
}

//0.8 Convert a raw Fraction matrix to String representation
func matrixToString(matrix:[[Fraction]]) -> [[String]] {
    var result:[[String]] = []
    var temp:[String] = []
    for x in 0..<matrix.count {
        for y in 0..<matrix[0].count {
            let holder = toString(matrix[x][y])
            temp.append(holder)
        }
        result.append(temp)
        temp = []
    }
    return result
}

//1.Ghaussian Elimination

//interchanging two rows
func swapRow (matrix:[[Fraction]], firstRow: Int, secondRow: Int) ->[[Fraction]]{
    let temp: [Fraction] = matrix[firstRow]
    var result:[[Fraction]] = matrix
    result[firstRow] = result[secondRow]
    result[secondRow] = temp
    return result
}

//multiplying a row by a constant
func multRow (row:[Fraction], constant:Fraction) -> [Fraction]{
    var temp:Fraction = 0
    var result:[Fraction]=[]
    for element in row {
        temp = element * constant
        result.append(temp)
    }
    return result
}



//replace one row with the sum of that row and a multiple of another row
func addMultRow(row1:[Fraction], row2:[Fraction], constant:Fraction) -> [Fraction]{
    var result:[Fraction] = []
    var temp:Fraction = 0
    let row3 = multRow(row2, constant:constant)
    for x in 0..<row1.count {
        temp = row1[x]+row3[x]
        result.append(temp)
    }
    return result
}


//Ghaussian elimination on a single row
func ghaussRow (matrix:[[Fraction]], startRow:Int) ->(matrix:[[Fraction]], determinantFactor:Fraction){
    var colNum:Int = 0
    var rowNum:Int = startRow
    var x:Int = 0
    var y:Int = startRow
    var found:Bool = false
    var result:[[Fraction]] = matrix
    var determinant:Fraction = 1
    while (x < result[0].count && found == false) {
        while (y < result.count && found == false) {
            if result[y][x].numerator != 0 {
                found = true
                rowNum = y
                colNum = x
            }
            y += 1
        }
        x += 1
        y = startRow
    }
    if rowNum != startRow {
        result = swapRow(result, firstRow:startRow, secondRow:rowNum)
        determinant = -determinant
    }
    if result[startRow][colNum].numerator != result[startRow][colNum].denominator && result[startRow][colNum].numerator != 0 {
        determinant *= result[startRow][colNum]
        print(result[startRow][colNum])
        result[startRow] = multRow(result[startRow],constant:1/result[startRow][colNum])
    }
    for k in 0..<result.count {
        if (result[k][colNum].numerator != 0) && k != startRow {
            let coefficient = -(result[k][colNum])
            result[k] = addMultRow(result[k], row2:result[startRow], constant:coefficient)
        }
    }
    return (result,determinant)
}

//the ghaussian elimination
func ghaussian (matrix:[[Fraction]]) ->(matrix:[[Fraction]], determinantFactor:Fraction){
    var tuple:([[Fraction]],Fraction) = ([],0)
    var result:[[Fraction]] = matrix
    var determinantFactor:Fraction = 1
    let minNum = min(result.count, result[0].count)
    for x in 0..<minNum {
        tuple = ghaussRow(result, startRow: x)
        result = tuple.0
        determinantFactor *= tuple.1
    }
    return (result,determinantFactor)
}




//2.Matrix Multiplication and Transpose

//dot product
func dotProduct(array1:[Fraction], array2:[Fraction]) -> Fraction{
    var result:Fraction = 0
    for x in 0..<array1.count {
        result += array1[x] * array2[x]
    }
    return result
}

//transpose a matrix
func transpose (matrix:[[Fraction]]) -> [[Fraction]]{
    var result:[[Fraction]]=[]
    var temp:[Fraction] = []
    for x in 0..<matrix[0].count{
        temp = []
        for y in 0..<matrix.count{
            temp.append(matrix[y][x])
        }
        result.append(temp)
    }
    return result
}



//multiplication of matrices
func multMatrices(matrix1:[[Fraction]], matrix2:[[Fraction]]) -> [[Fraction]]? {
    if matrix1[0].count != matrix2.count {
        print("Invalid inputs")
        return nil
    } else {
        let transposed2 = transpose(matrix2)
        var temp:[Fraction] = []
        var result:[[Fraction]] = []
        for x in 0..<matrix1.count {
            temp = []
            for y in 0..<transposed2.count {
                temp.append(dotProduct(matrix1[x], array2: transposed2[y]))
            }
            result.append(temp)
        }
        return result
    }
}


//3.Matrix addition and subtraction

func addMatrices(matrix1:[[Fraction]], matrix2:[[Fraction]]) ->[[Fraction]]? {
    if matrix1.count != matrix2.count || matrix1[0].count != matrix2[0].count {
        print("Invalid inputs")
        return nil
    } else {
        var result:[[Fraction]] = []
        var temp:[Fraction] = []
        for x in 0..<matrix1.count {
            temp = []
            for y in 0..<matrix1[1].count {
                temp.append(matrix1[x][y]+matrix2[x][y])
            }
            result.append(temp)
        }
        return result
    }
}

func subtractMatrices(matrix1:[[Fraction]], matrix2:[[Fraction]]) ->[[Fraction]]? {
    if matrix1.count != matrix2.count || matrix1[0].count != matrix2[0].count {
        print("Invalid inputs")
        return nil
    } else {
        var result:[[Fraction]] = []
        var temp:[Fraction] = []
        for x in 0..<matrix1.count {
            temp = []
            for y in 0..<matrix1[1].count {
                temp.append(matrix1[x][y]-matrix2[x][y])
            }
            result.append(temp)
        }
        return result
    }
}

//4.row Equivalence
func isRowEquivalent(matrix1:[[Fraction]], matrix2:[[Fraction]]) ->Bool {
    let result1 = ghaussian(matrix1).matrix
    let result2 = ghaussian(matrix2).matrix
    return equalFractionMatrix(result1, matrix2: result2)
}

//5.find the inverse of a matrix

//generate an identity matrix with a certain dimention
func identityMatrix(dimension:Int) ->[[Fraction]] {
    var result:[[Fraction]] = []
    var temp:[Fraction] = []
    for x in 0..<dimension {
        temp = []
        for y in 0..<dimension {
            if x == y {
                temp.append(1)
            } else {
                temp.append(0)
            }
        }
        result.append(temp)
    }
    return result
}

//determine whether a matrix is invertible
func isInvertible(matrix:[[Fraction]]) ->Bool {
    if matrix[0].count == matrix.count && equalFractionMatrix(ghaussian(matrix).matrix, matrix2: identityMatrix(matrix.count))  {
        return true
    }
    return false
}

//cut a matrix from a col index
func cutMatrix(matrix:[[Fraction]], index:Int) ->[[Fraction]]{
    var result:[[Fraction]] = []
    var temp:[Fraction] = []
    for x in 0..<matrix.count {
        temp = []
        for y in index..<matrix[0].count {
            temp.append(matrix[x][y])
        }
        result.append(temp)
    }
    return result
}

//find the inverse of a matrix
func inverse(matrix:[[Fraction]]) -> [[Fraction]]? {
    if !isInvertible(matrix) {
        print("Invalid input")
        return nil
    } else {
        let identity:[[Fraction]] = identityMatrix(matrix.count)
        var intermediate:[[Fraction]] = matrix
        for x in 0..<matrix.count {
            intermediate[x] += identity[x]
        }
        let intermediate2 = ghaussian(intermediate).matrix
        let result:[[Fraction]] = cutMatrix(intermediate2, index:matrix.count)
        return result
    }
}

//6.Rank

//check zero rows
func zeroRow(row:[Fraction]) -> Bool {
    for x in 0..<row.count {
        if row[x].numerator != 0 {
            return false
        }
    }
    return true
}

//find the rank of a matrix
func rank(matrix:[[Fraction]]) -> Int {
    if isInvertible(matrix) {
        return matrix.count
    } else {
        let reduced = ghaussian(matrix).matrix
        var result:Int = 0
        for x in 0..<reduced.count {
            if(!zeroRow(reduced[x])) {
                result += 1
            }
        }
        return result
    }
}


//7.Determinant

//lower or opper triangular matrix
func upperMatrix(matrix:[[Fraction]]) -> Bool {
    for x in 1..<matrix.count {
        for y in 0..<x {
            if matrix[x][y].numerator != 0 {
                return false
            }
        }
    }
    return true
}

func lowerMatrix(matrix:[[Fraction]]) -> Bool {
    for x in 0..<matrix.count-1 {
        for y in x+1..<matrix[0].count {
            if matrix[x][y].numerator != 0 {
                return false
            }
        }
    }
    return true
}

//product of diagonal
func productDiagonal(matrix:[[Fraction]]) -> Fraction {
    var result:Fraction = 1
    for x in 0..<matrix.count {
        result *= matrix[x][x]
    }
    return result
}

//find the determinant of a matrix
func determinant(matrix:[[Fraction]]) -> Fraction? {
    if matrix.count != matrix[0].count {
        print("Invalid input")
        return nil
    } else {
        let tuple:([[Fraction]],Fraction) = ghaussian(matrix)
        let ghaussianMatrix = tuple.0
        let determinantFactor = tuple.1
        for x in 0..<ghaussianMatrix.count {
            if zeroRow(ghaussianMatrix[x]) {
                return 0
            }
        }
        if equalFractionMatrix(ghaussianMatrix, matrix2: identityMatrix(ghaussianMatrix.count)) {
            return determinantFactor
        } else if lowerMatrix(ghaussianMatrix) || upperMatrix(ghaussianMatrix) {
            return determinantFactor * productDiagonal(ghaussianMatrix)
        } else {
            return nil
        }
    }
}


//8.Trace
func trace(matrix:[[Fraction]]) -> Fraction? {
    if matrix.count == matrix[0].count {
        var result:Fraction = 0
        for x in 0..<matrix.count {
            result += matrix[x][x]
        }
        return result
    } else {
        print("Invalid input")
        return nil
    }
}

//9. Multiplication by a scalar
func scalarMult(matrix:[[Fraction]], constant:Fraction) -> [[Fraction]] {
    var result:[[Fraction]] = matrix
    for x in 0..<matrix.count {
        result[x] = multRow(matrix[x], constant: constant)
    }
    return result
}

//10. Addition and deletion of the last row

//addition of a row
func addRow(matrix:[[Fraction]]) -> [[Fraction]] {
    var result:[[Fraction]] = matrix
    let col = matrix[0].count
    let newRow = [Fraction](count: col, repeatedValue: 0)
    result.append(newRow)
    return result
}

//remove the last row
func removeRow(matrix:[[Fraction]]) -> [[Fraction]] {
    var result:[[Fraction]] = matrix
    if matrix.count > 1 {
        result.removeLast()
    }
    return result
}

//11. Addition and deletion of the last col

//add a new column to the last
func addCol(matrix:[[Fraction]]) -> [[Fraction]] {
    var result:[[Fraction]] = matrix
    for x in 0..<matrix.count {
        result[x].append(0)
    }
    return result
}


//remove the last col
func removeCol(matrix:[[Fraction]]) -> [[Fraction]] {
    var result:[[Fraction]] = matrix
    if matrix[0].count > 1 {
        for x in 0..<matrix.count {
            result[x].removeLast()
        }
    }
    return result
}

//12. Negate a matrix
func negate(matrix:[[Fraction]]) -> [[Fraction]] {
    var result:[[Fraction]] = matrix
    for x in 0..<matrix.count {
        for y in 0..<matrix[0].count {
            if result[x][y] != 0 {
                result[x][y] = -result[x][y]
            }
        }
    }
    return result
}


//14.Convert a double to a fraction
func doubleToFraction(input:Double) -> Fraction {
    var temp:Double = input
    var denom:Int = 1
    while(temp - floor(temp) != 0){
        temp *= 10
        denom *= 10
    }
    let(numerator, denominator) = reduce(numerator: Int(temp), denominator: denom)
    return Fraction(numerator: numerator, denominator: denominator)
}

//15. Convert an int to a fraction
func intToFraction(input:Int) -> Fraction {
    return Fraction(numerator:input, denominator: 1)
}



   




