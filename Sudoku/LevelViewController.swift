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
    let selectLevelSegue = "SelectLevelSegue"
    var sudokuManager: SudokuManager?
    var selectedSudokuLevel: Int?
    
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
    
    // Pass data to other view controllers via segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == self.selectLevelSegue {
            if let navigationController = segue.destinationViewController as? UINavigationController {
                if let destination = navigationController.topViewController as? SudokuViewController {
                    prepareSudokuView(destination)
                }
            }
        }
    }
    
    // MARK: User Actions
    @IBAction func selectedLevel(sender: UIButton) {
        self.selectedSudokuLevel = Int(sender.titleLabel!.text!)! - 1
        print(self.selectedSudokuLevel)
        performSegueWithIdentifier(self.selectLevelSegue, sender: self)
    }
    
    // MARK: Private Interface
    private func prepareSudokuView(destinationViewController: SudokuViewController) {
        destinationViewController.sudokuManager = self.sudokuManager
        destinationViewController.sudokuManager!.setActiveSudoku(self.selectedSudokuLevel!)
    }
}
