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
        return cell
    }
    
    // Selection behaviour
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // You can use indexPath to get "cell number x", or get the cell like:
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! SudokuCollectionViewCell
        cell.value.text = "yes"
    }
    
    // Margins and padding from edge of layout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    }
    
    // Spacing between cells
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    // Dimensions of each cell
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 5.0, height: 10.0)
    }
    
    // MARK: Helpers
    func formatCell(cell: SudokuCollectionViewCell, indexPath: NSIndexPath) {
        cell.layer.borderWidth = sudokuCollectionViewCellBorderWidth
        cell.layer.borderColor = sudokuCollectionViewCellBorderColor
//        cell.value.text = "0"
//        cell.frame = customCellFrame(indexPath)
    }
    
    func customCellFrame(indexPath: NSIndexPath) -> CGRect {
        let screenSize = sudokuCollectionView.bounds
        let cellSize = screenSize.width / CGFloat(cellColumns)
        let xPosition = indexPath.row % cellRows
        let yPosition = indexPath.row / cellRows
        return CGRect(x: cellSize * CGFloat(xPosition),
            y: cellSize * CGFloat(yPosition), width: cellSize, height: cellSize)
    }
    
    func getSudokuCollectionViewCells() -> [SudokuCollectionViewCell!] {
        let sudokuCollectionViewCells = [SudokuCollectionViewCell!](count: (cellRows * cellColumns), repeatedValue: nil)
        return sudokuCollectionViewCells
    }
    
}
