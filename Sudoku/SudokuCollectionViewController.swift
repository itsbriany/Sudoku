//
//  SudokuCollectionViewController.swift
//  Sudoku
//
//  Created by Brian Yip on 2016-01-18.
//  Copyright © 2016 Brian Yip. All rights reserved.
//

import UIKit

class SudokuCollectionViewController: UICollectionViewController {
   
    // TODO Implement a picker view each time a ZERO is tapped
    // TODO Fill the View, NOT THE SCREEN!
    
    // MARK: Properties
    let cellRows = 9
    let cellColumns = 9
    let sudokuCollectionViewControllerCellIdentifier = "SudokuCollectionViewCell"
    let sudokuCollectionViewCellBorderWidth: CGFloat = 1
    let sudokuCollectionViewCellBorderColor = UIColor.blackColor().CGColor
    var sudokuManager: SudokuManager?
    
    // MARK: UICollectionViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        sudokuManager = SudokuManager(format: SudokuFormat(rows: cellRows, columns: cellColumns))
    }
    
//    override func collectionView(collectionView: UICollectionView,
//        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        return formatCell(indexPath)
//    }
    
//    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return getSudokuCollectionViewCells().count
//    }
    
    // MARK: User Gestures
    func chooseNumber(gesture: UITapGestureRecognizer) {
        print("Choosing a number")
        // let numberSelection = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    }
    
    // MARK: Helpers
    func formatCell(indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView!.dequeueReusableCellWithReuseIdentifier(sudokuCollectionViewControllerCellIdentifier,
            forIndexPath: indexPath) as! SudokuCollectionViewCell
        cell.layer.borderWidth = sudokuCollectionViewCellBorderWidth
        cell.layer.borderColor = sudokuCollectionViewCellBorderColor
        cell.frame = customCellFrame(indexPath)
        sudokuManager?.loadSudokuValueIntoCell(indexPath, cell: cell)
        addUIGestures(indexPath, cell: cell)
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
    
    func getSudokuCollectionViewCells() -> [SudokuCollectionViewCell!] {
        let sudokuCollectionViewCells = [SudokuCollectionViewCell!](count: (cellRows * cellColumns), repeatedValue: nil)
        return sudokuCollectionViewCells
    }
    
    func addUIGestures(indexPath: NSIndexPath, cell: SudokuCollectionViewCell) {
        let nameTapRecognizer = UITapGestureRecognizer(target: self, action: Selector("chooseNumber:"))
        nameTapRecognizer.cancelsTouchesInView = false
        nameTapRecognizer.numberOfTapsRequired = 1
        cell.addGestureRecognizer(nameTapRecognizer)
    }

}
