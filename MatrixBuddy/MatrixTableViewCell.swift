//
//  MatrixTableViewCell.swift
//  MatrixBuddy
//
//  Created by Chris Gao on 9/11/16.
//  Copyright © 2016 Balabala & Company. All rights reserved.
//

import UIKit

class MatrixTableViewCell: UITableViewCell {

    @IBOutlet weak var firstOp: UILabel!
    
    @IBOutlet weak var firstMatrix: UIStackView!
    
    @IBOutlet weak var secondOp: UILabel!
    
    @IBOutlet weak var secondMatrix: UIStackView!
    
    @IBOutlet weak var equals: UILabel!
    
    @IBOutlet weak var result: UIStackView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
