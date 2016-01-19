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
    let sudokuCollectionViewControllerCellIdentifier = "BoxCollectionViewCell"
    let sudokuCollectionViewCells = [BoxCollectionViewCell!](count: 9, repeatedValue: nil)
    let sudokuCollectionViewCellBorderWidth: CGFloat = 1
    let sudokuCollectionViewCellBorderColor = UIColor.blackColor().CGColor
    
    // MARK: UICollectionViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(sudokuCollectionViewControllerCellIdentifier,
                forIndexPath: indexPath)
            cell.layer.borderWidth = sudokuCollectionViewCellBorderWidth
            cell.layer.borderColor = sudokuCollectionViewCellBorderColor
            return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sudokuCollectionViewCells.count
    }
}
