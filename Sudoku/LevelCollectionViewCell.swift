//
//  LevelCollectionViewCell.swift
//  Sudoku
//
//  Created by Brian Yip on 2016-02-05.
//  Copyright © 2016 Brian Yip. All rights reserved.
//

import UIKit

class LevelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var level: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 1
        layer.cornerRadius = 5
    }
}
