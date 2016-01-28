//
//  SudokuViewController.swift
//  Sudoku
//
//  Created by Brian Yip on 2016-01-26.
//  Copyright © 2016 Brian Yip. All rights reserved.
//

import UIKit

class SudokuViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var sudokuCollectionView: SudokuCollectionView!
    
    // TODO Implement a picker view each time a ZERO is tapped
    // TODO Fill the View, NOT THE SCREEN!
    
    // MARK: Properties
    let cellRows = 9
    let cellColumns = 9
    let sudokuCellIdentifier = "SudokuCollectionViewCell"
    let sudokuCollectionViewCellBorderWidth: CGFloat = 1
    let sudokuCollectionViewCellBorderColor = UIColor.blackColor().CGColor
    var sudokuManager: SudokuManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sudokuManager = SudokuManager(format: SudokuFormat(rows: cellRows, columns: cellColumns))
    }
    
    // Cell count
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getSudokuCollectionViewCells().count
    }
    
    // Load the cells in the collection view
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(sudokuCellIdentifier, forIndexPath: indexPath) as! SudokuCollectionViewCell
        formatCell(cell, indexPath: indexPath)
        sudokuManager?.loadSudokuValueIntoCell(indexPath, cell: cell)
        // TODO dynamically size the sudoku layout based on the sizes of the cells
        return cell
    }
    
    // Selection behaviour
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // You can use indexPath to get "cell number x", or get the cell like:
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! SudokuCollectionViewCell
        cell.value.text = "yes"
    }
    
    // Dimensions of each cell
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return customCellFrame(indexPath)
    }
    
    // MARK: Helpers
    func formatCell(cell: SudokuCollectionViewCell, indexPath: NSIndexPath) {
        cell.layer.borderWidth = sudokuCollectionViewCellBorderWidth
        cell.layer.borderColor = sudokuCollectionViewCellBorderColor
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 3;
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
