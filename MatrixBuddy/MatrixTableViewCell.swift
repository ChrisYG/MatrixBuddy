//
//  MatrixTableViewCell.swift
//  MatrixBuddy
//
//  Created by Chris Gao on 8/16/16.
//  Copyright © 2016 Balabala & Company. All rights reserved.
//

import UIKit

class MatrixTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstOp: UILabel!
    
    
    @IBOutlet weak var firstMatrix: UIStackView!
    
    @IBOutlet weak var secondOp: UILabel!
    
    /**
    func setCollectionViewDataSourceDelegate
        <D: protocol<UIStackViewDataSource, UIStackViewDelegate>>
        (dataSourceDelegate: D, forRow row: Int) {
        
        firstMatrix.delegate = dataSourceDelegate
        firstMatrix.dataSource = dataSourceDelegate
        firstMatrix.tag = row
        firstMatrix.reloadData()
    } **/
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
