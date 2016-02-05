//
//  LevelViewController.swift
//  Sudoku
//
//  Created by Brian Yip on 2016-02-05.
//  Copyright © 2016 Brian Yip. All rights reserved.
//

import UIKit

class LevelViewController: UICollectionViewController {

    let cellIdentifier = "LevelCollectionViewCell"
    
    // TODO Pass the sudokuDBmanager via a segue to SudokuViewController
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.cellIdentifier, forIndexPath: indexPath) as! LevelCollectionViewCell
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
}
