//
//  SudokuViewController.swift
//  Sudoku
//
//  Created by Brian Yip on 2016-01-26.
//  Copyright © 2016 Brian Yip. All rights reserved.
//

import UIKit

class SudokuViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var sudokuInputCollectionView: UICollectionView!
    @IBOutlet weak var sudokuCollectionView: UICollectionView!
    
    // TODO Implement a picker view each time a ZERO is tapped
    // TODO Fill the View, NOT THE SCREEN!
    
    // MARK: Properties
    let cellRows = 9
    let cellColumns = 9
    let sudokuCellIdentifier = "SudokuCollectionViewCell"
    let sudokuButtonCellIdentifier = "SudokuButtonCollectionViewCell"
    let sudokuCollectionViewCellBorderWidth: CGFloat = 1
    let sudokuCollectionViewCellBorderColor = UIColor.blackColor().CGColor
    let selectedSudokuCollectionViewCellBorderColor = UIColor.greenColor().CGColor
    var sudokuManager: SudokuManager?
    var selectedSudokuCell: SudokuCollectionViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sudokuManager = SudokuManager(format: SudokuFormat(rows: self.cellRows, columns: self.cellColumns))
    }
    
    // Cell count
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.sudokuInputCollectionView) {
            return 9
        }
        if (collectionView == self.sudokuCollectionView) {
            return getSudokuCollectionViewCells().count
        }
        return getSudokuCollectionViewCells().count
    }
    
    // Load the cells in the collection view
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if (collectionView == self.sudokuCollectionView) {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.sudokuCellIdentifier, forIndexPath: indexPath) as! SudokuCollectionViewCell
            formatSudokuCell(cell, indexPath: indexPath)
            self.sudokuManager?.loadSudokuValueIntoCell(indexPath, cell: cell)
            return cell
        }
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.sudokuButtonCellIdentifier, forIndexPath: indexPath) as! SudokuButtonCollectionViewCell
        formatInputCell(cell, indexPath: indexPath)
        return cell
    }
    
    // Selection behaviour
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if (collectionView == self.sudokuCollectionView) {
            
            if (self.selectedSudokuCell != nil) {
                self.selectedSudokuCell!.layer.borderColor = self.sudokuCollectionViewCellBorderColor
            }
            
            // You can use indexPath to get "cell number x", or get the cell like:
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! SudokuCollectionViewCell
            self.selectedSudokuCell = cell
            self.selectedSudokuCell!.layer.borderColor = self.selectedSudokuCollectionViewCellBorderColor
            return
        }
    }
    
    // Dimensions of each cell
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return customCellFrame(indexPath)
    }
    
    @IBAction func updateSelection(sender: UIButton) {
        if ((self.selectedSudokuCell) != nil) {
            self.selectedSudokuCell?.value.text = sender.titleLabel?.text
            return
        }
    }
    

    // MARK: Helpers
    func formatSudokuCell(cell: SudokuCollectionViewCell, indexPath: NSIndexPath) {
        cell.layer.borderWidth = sudokuCollectionViewCellBorderWidth
        cell.layer.borderColor = sudokuCollectionViewCellBorderColor
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 3;
    }
    
    func formatInputCell(cell: SudokuButtonCollectionViewCell, indexPath: NSIndexPath) {
        cell.layer.borderColor = sudokuCollectionViewCellBorderColor
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 3;
        cell.value.setTitle(String(indexPath.row + 1), forState: .Normal)
    }
    
    func customCellFrame(indexPath: NSIndexPath) -> CGSize {
        let screenSize = sudokuCollectionView.bounds
        let cellSize = screenSize.width / (CGFloat(cellColumns) + 3) // +3 to make up for padding and margins
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func getSudokuCollectionViewCells() -> [SudokuCollectionViewCell!] {
        let sudokuCollectionViewCells = [SudokuCollectionViewCell!](count: (cellRows * cellColumns), repeatedValue: nil)
        return sudokuCollectionViewCells
    }
    
}
