//
//  SudokuCollectionViewController.swift
//  Sudoku
//
//  Created by Brian Yip on 2016-01-18.
//  Copyright © 2016 Brian Yip. All rights reserved.
//

import UIKit

class SudokuCollectionViewController: UICollectionViewController {
   
    // MARK: Properties
    let cellRows = 9
    let cellColumns = 9
    let sudokuCollectionViewControllerCellIdentifier = "BoxCollectionViewCell"
    let sudokuCollectionViewCellBorderWidth: CGFloat = 1
    let sudokuCollectionViewCellBorderColor = UIColor.blackColor().CGColor
    var sudokuManager: SudokuManager?
    
    // MARK: UICollectionViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        sudokuManager = SudokuManager(format: SudokuFormat(rows: cellRows, columns: cellColumns))
    }
    
    override func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return formatCell(indexPath)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getSudokuCollectionViewCells().count
    }
    
    // MARK: Helpers
    func formatCell(indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView!.dequeueReusableCellWithReuseIdentifier(sudokuCollectionViewControllerCellIdentifier,
            forIndexPath: indexPath) as! BoxCollectionViewCell
        cell.layer.borderWidth = sudokuCollectionViewCellBorderWidth
        cell.layer.borderColor = sudokuCollectionViewCellBorderColor
        cell.frame = customCellFrame(indexPath)
        // TODO Might want to use a button instead of a label
        sudokuManager?.loadSudokuValueIntoCell(indexPath, cell: cell)
        return cell
    }
    
    func customCellFrame(cellIndexPath: NSIndexPath) -> CGRect {
        let screenSize = UIScreen.mainScreen().bounds
        let cellSize = screenSize.width / CGFloat(cellColumns)
        let xPosition = cellIndexPath.row % cellRows
        let yPosition = cellIndexPath.row / cellRows
        return CGRect(x: cellSize * CGFloat(xPosition),
            y: cellSize * CGFloat(yPosition), width: cellSize, height: cellSize)
    }
    

    
    func getSudokuCollectionViewCells() -> [BoxCollectionViewCell!] {
        let sudokuCollectionViewCells = [BoxCollectionViewCell!](count: (cellRows * cellColumns), repeatedValue: nil)
        return sudokuCollectionViewCells
    }

}
