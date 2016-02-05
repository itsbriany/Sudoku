//
//  SudokuViewController.swift
//  Sudoku
//
//  Created by Brian Yip on 2016-01-26.
//  Copyright © 2016 Brian Yip. All rights reserved.
//

import UIKit

class SudokuViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var sudokuInputCollectionView: UICollectionView!
    @IBOutlet weak var sudokuCollectionView: UICollectionView!
    @IBOutlet weak var gameStatus: UILabel!
    
    // MARK: Properties
    let inputButtons = 9
    let sudokuCellIdentifier = "SudokuCollectionViewCell"
    let sudokuButtonCellIdentifier = "SudokuButtonCollectionViewCell"
    let levelSelectionSegue = "SelectLevelSegue"
    let homeSegue = "HomeSegue"
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
            return loadSudokuCollectionViewCell(collectionView, cellForItemAtIndexPath: indexPath)
        }
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.sudokuButtonCellIdentifier, forIndexPath: indexPath) as! SudokuButtonCollectionViewCell
        formatInputCell(cell, indexPath: indexPath)
        return cell
    }
    
    // Selection behaviour
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if (collectionView == self.sudokuCollectionView) {
            resetSelectedCellBorder()
            selectCell(didSelectItemAtIndexPath: indexPath)
            highlightSelectedCellBorder()
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
            let index = self.sudokuCollectionView.indexPathForCell(self.selectedSudokuCell!)
            let row = index!.row / sudokuManager!.format!.rows
            let column = index!.row % sudokuManager!.format!.columns
            let value: Int = Int(self.selectedSudokuCell!.value.text!)!
            self.sudokuManager!.updateActiveSudoku(row, columnIndex: column, value: value)
            return
        }
    }
    
    // MARK: User Actions
    @IBAction func checkSudoku(sender: UIBarButtonItem) {
        self.gameStatus.hidden = false
        if (self.sudokuManager!.activeSudoku!.isSolved()) {
            self.gameStatus.textColor = UIColor.greenColor()
            self.gameStatus.text = self.winText;
            return
        }
        self.gameStatus.textColor = UIColor.redColor()
        self.gameStatus.text = self.loseText
    }
    
    @IBAction func resetSudoku(sender: UIBarButtonItem) {
        self.sudokuManager!.resetActiveSudoku()
        refreshSudokuCollectionView()
    }
    
    @IBAction func solveSudoku(sender: AnyObject) {
        self.sudokuManager!.solveActiveSudoku()
        refreshSudokuCollectionView()
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == self.levelSelectionSegue {
            if let navigationController = segue.destinationViewController as? UINavigationController {
                if let destination = navigationController.topViewController as? LevelViewController {
                    destination.sudokuManager = self.sudokuManager
                }
            }
        } else if segue.identifier == self.homeSegue {
            if let navigationController = segue.destinationViewController as? UINavigationController {
                if let destination = navigationController.topViewController as? HomeViewController {
                    destination.sudokuManager = self.sudokuManager
                }
            }
        }
    }
    
    // MARK: Helpers
    private func formatSudokuCell(cell: SudokuCollectionViewCell, indexPath: NSIndexPath) {
        cell.layer.borderWidth = self.sudokuCollectionViewCellBorderWidth
        cell.layer.borderColor = self.sudokuCollectionViewCellBorderColor
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 3;
    }
    
    private func formatInputCell(cell: SudokuButtonCollectionViewCell, indexPath: NSIndexPath) {
        cell.layer.borderWidth = self.sudokuCollectionViewCellBorderWidth
        cell.layer.borderColor = self.sudokuCollectionViewCellBorderColor
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 3;
        cell.value.setTitle(String(indexPath.row + 1), forState: .Normal)
    }
    
    private func customCellFrame(indexPath: NSIndexPath) -> CGSize {
        let screenSize = sudokuCollectionView.bounds
        let cellSize = screenSize.width / (CGFloat(self.sudokuManager!.format!.columns) + 3) // +3 to make up for padding and margins
        return CGSize(width: cellSize, height: cellSize)
    }
    
    private func getSudokuCollectionViewCells() -> [SudokuCollectionViewCell!] {
        let sudokuCollectionViewCells = [SudokuCollectionViewCell!](count: self.sudokuManager!.format!.rows * self.sudokuManager!.format!.columns, repeatedValue: nil)
        return sudokuCollectionViewCells
    }
    
    private func resetSelectedCellBorder() {
        if (self.selectedSudokuCell != nil) {
            self.selectedSudokuCell!.layer.borderColor = self.sudokuCollectionViewCellBorderColor
            self.selectedSudokuCell!.layer.borderWidth = self.sudokuCollectionViewCellBorderWidth
        }
    }
    
    private func highlightSelectedCellBorder() {
        self.selectedSudokuCell!.layer.borderColor = self.selectedSudokuCollectionViewCellBorderColor
        self.selectedSudokuCell!.layer.borderWidth = self.selectedSudokuCollectionViewCellBorderWidth
    }
    
    private func selectCell(didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = self.sudokuCollectionView.cellForItemAtIndexPath(indexPath) as! SudokuCollectionViewCell
        self.selectedSudokuCell = cell
    }
    
    private func loadSudokuCollectionViewCell(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> SudokuCollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.sudokuCellIdentifier, forIndexPath: indexPath) as! SudokuCollectionViewCell
        formatSudokuCell(cell, indexPath: indexPath)
        self.sudokuManager?.loadSudokuValueIntoCell(indexPath, cell: cell, firstLoad: true)
        return cell
    }
    
    private func refreshSudokuCollectionView() {
        for indexPath in self.sudokuCollectionView.indexPathsForVisibleItems() {
            let cell = self.sudokuCollectionView.cellForItemAtIndexPath(indexPath) as! SudokuCollectionViewCell
            self.sudokuManager!.loadSudokuValueIntoCell(indexPath, cell: cell, firstLoad: false)
        }
    }
    
}
