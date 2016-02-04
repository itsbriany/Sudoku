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
    @IBOutlet weak var gameStatus: UILabel!
    
    // MARK: Properties
    let cellRows = 9
    let cellColumns = 9
    let inputButtons = 9
    let sudokuCellIdentifier = "SudokuCollectionViewCell"
    let sudokuButtonCellIdentifier = "SudokuButtonCollectionViewCell"
    let sudokuCollectionViewCellBorderColor = UIColor.blackColor().CGColor
    let selectedSudokuCollectionViewCellBorderColor = UIColor.yellowColor().CGColor
    let selectedSudokuCollectionViewCellBorderWidth: CGFloat = 3
    let sudokuCollectionViewCellBorderWidth: CGFloat = 1
    let winText = "You did it!"
    let loseText = "Nope, that's not it."

    var sudokuManager: SudokuManager?
    var selectedSudokuCell: SudokuCollectionViewCell?
    
    // Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        sudokuManager = SudokuManager(format: SudokuFormat(rows: self.cellRows, columns: self.cellColumns))
    }
    
    // Cell count
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.sudokuInputCollectionView) {
            return self.inputButtons
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
                self.selectedSudokuCell!.layer.borderWidth = self.sudokuCollectionViewCellBorderWidth
            }
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! SudokuCollectionViewCell
            self.selectedSudokuCell = cell
            self.selectedSudokuCell!.layer.borderColor = self.selectedSudokuCollectionViewCellBorderColor
            self.selectedSudokuCell!.layer.borderWidth = self.selectedSudokuCollectionViewCellBorderWidth
            return
        }
    }
    
    // Dimensions of each cell
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return customCellFrame(indexPath)
    }
    
    // Click on an input cell
    @IBAction func updateSelection(sender: UIButton) {
        if ((self.selectedSudokuCell) != nil) {
            self.selectedSudokuCell?.value.text = sender.titleLabel?.text
            // TODO update the data model with the selected value
            //self.sudokuManager?.updateActiveSudoku(<#T##rowIndex: Int##Int#>, columnIndex: <#T##Int#>, value: <#T##Int#>)
            return
        }
    }
    
    // Check the sudoku
    @IBAction func checkSudoku(sender: UIButton) {
        self.gameStatus.hidden = false
        if (self.sudokuManager!.activeSudoku!.isSolved()) {
            self.gameStatus.textColor = UIColor.greenColor()
            self.gameStatus.text = self.winText;
            return
        }
        self.gameStatus.textColor = UIColor.redColor()
        self.gameStatus.text = self.loseText
    }
    
    
    // MARK: Helpers
    func formatSudokuCell(cell: SudokuCollectionViewCell, indexPath: NSIndexPath) {
        cell.layer.borderWidth = self.sudokuCollectionViewCellBorderWidth
        cell.layer.borderColor = self.sudokuCollectionViewCellBorderColor
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 3;
    }
    
    func formatInputCell(cell: SudokuButtonCollectionViewCell, indexPath: NSIndexPath) {
        cell.layer.borderWidth = self.sudokuCollectionViewCellBorderWidth
        cell.layer.borderColor = self.sudokuCollectionViewCellBorderColor
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
