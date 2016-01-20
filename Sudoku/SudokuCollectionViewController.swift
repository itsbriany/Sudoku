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
    
    // MARK: UICollectionViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()
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
        // TODO The cells are overlapping!
        cell.frame = customCellFrame(0, y: 0)
        return cell
    }
    
    func customCellFrame(x: CGFloat, y: CGFloat) -> CGRect {
        let screenSize = UIScreen.mainScreen().bounds
        let cellSize = screenSize.width / CGFloat(cellColumns)
        return CGRect(x: x, y: y, width: cellSize, height: cellSize)
    }
    
    func getSudokuCollectionViewCells() -> [BoxCollectionViewCell!] {
        let sudokuCollectionViewCells = [BoxCollectionViewCell!](count: (cellRows * cellColumns), repeatedValue: nil)
        return sudokuCollectionViewCells
    }

}
