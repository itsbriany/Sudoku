//
//  LevelViewController.swift
//  Sudoku
//
//  Created by Brian Yip on 2016-02-05.
//  Copyright © 2016 Brian Yip. All rights reserved.
//

import UIKit

class LevelViewController: UICollectionViewController {

    // MARK: Properties
    let cellIdentifier = "LevelCollectionViewCell"
    var sudokuManager: SudokuManager?
    
    // MARK: Overrides
    // Define cells
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.cellIdentifier, forIndexPath: indexPath) as! LevelCollectionViewCell
        cell.level.setTitle(String(indexPath.row + 1), forState: .Normal)
        return cell
    }
    
    // How many cells?
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sudokuManager!.sudokus.count
    }
}
